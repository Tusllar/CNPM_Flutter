from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from time import sleep
from bs4 import BeautifulSoup
# from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
# from bs4 import BeautifulSoup
import time
import json
import mysql.connector
from datetime import datetime
from selenium.common.exceptions import NoSuchElementException, ElementClickInterceptedException
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from time import sleep
from bs4 import BeautifulSoup
import mysql.connector
json_file='data.json'
db = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="Tranvantu@294",
    database="crawl"
)
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()))
driver =  webdriver.Chrome()

def save_movie_now(connection, moviedata):
    try:
        cursor = connection.cursor()
        insert_query = """
        INSERT INTO movie (movie_id,video_id,title, director, actors, genre, time_movie,duration,lang, rating, review, poster_url, background_url)
        VALUES (%s,%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(insert_query, moviedata)
        connection.commit()  # Lưu thay đổi
        movie_id = cursor.lastrowid  # Lấy ID phim vừa lưu
        movie_data_dict = {
            'movie_id': movie_id,
            'video_id': moviedata[1],
            'title': moviedata[2],
            'director': moviedata[3],
            'actors': moviedata[4],
            'genre': moviedata[5],
            'time_movie': moviedata[6],
            'duration': moviedata[7],
            'lang': moviedata[8],
            'rating': moviedata[9],
            'review': moviedata[10],
            'poster_url': moviedata[11],
            'background_url': moviedata[12],
        }
        
        with open(json_file, 'w') as file:
            json.dump([movie_data_dict], file, indent=4)
        return movie_id
    except mysql.connector.Error as e:
        print(f"Lỗi khi chèn dữ liệu phim: {e}")
        return None
    finally:
        cursor.close()

def save_movie_soon(connection, moviedata):
    try:
        cursor = connection.cursor()
        insert_query = """
        INSERT INTO coomingsoon (video_id,title, director, actors, genre, time_movie,duration,lang, rating, review, poster_url, background_url)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(insert_query, moviedata)
        connection.commit()  # Lưu thay đổi
        movie_id = cursor.lastrowid  # Lấy ID phim vừa lưu
        movie_data_dict = {
            'movie_id': movie_id,
            'video_id': moviedata[1],
            'title': moviedata[2],
            'director': moviedata[3],
            'actors': moviedata[4],
            'genre': moviedata[5],
            'time_movie': moviedata[6],
            'duration': moviedata[7],
            'lang': moviedata[8],
            'rating': moviedata[9],
            'review': moviedata[10],
            'poster_url': moviedata[11],
            'background_url': moviedata[12],
        }
        
        try:
            with open(json_file, 'r') as file:
                existing_data = json.load(file)
        except (FileNotFoundError, json.JSONDecodeError):
            existing_data = []

        # Thêm dữ liệu phim mới vào danh sách
        existing_data.append(movie_data_dict)

        # Ghi lại dữ liệu vào tệp JSON
        with open(json_file, 'w') as file:
            json.dump(existing_data, file, indent=4)
        return movie_id
    except mysql.connector.Error as e:
        print(f"Lỗi khi chèn dữ liệu phim: {e}")
        return None
    finally:
        cursor.close()

def remove_movie():
    try:
        cursor = db.cursor()
        
        # Xóa tất cả các bản ghi trong bảng movies
        delete_movies_query = "DELETE FROM movie"
        cursor.execute(delete_movies_query)
        
        # Xác nhận việc xóa
        db.commit()
        print("Đã xóa tất cả các phim.")

    except mysql.connector.Error as e:
        print(f"Đã xảy ra lỗi: {e}")
        db.rollback()

def Getlink(n):
# Giả sử driver đã được khởi tạo và trang đã được tải
    page_source = BeautifulSoup(driver.page_source, 'html.parser')
    profiles = page_source.find_all('li', class_='film-lists item last')
    # Danh sách để lưu tất cả thông tin phim
    all_movies_info = []
    movie_link_all=[]
    for profile in profiles:
        movie_info = {}
        
        # Tìm tiêu đề phim
        movie_title_tag = profile.find('h2', class_='product-name')
        if movie_title_tag:
            movie_title = movie_title_tag.get_text(strip=True)
            movie_info['title'] = movie_title
            
            # Lấy liên kết của phim
            movie_link_tag = movie_title_tag.find('a')
            if movie_link_tag and 'href' in movie_link_tag.attrs:
                movie_info['link'] = movie_link_tag['href']
                all_link = movie_link_tag['href']
                movie_link_all.append(all_link)
            else:
                movie_info['link'] = 'Không có liên kết'
        
        else:
            print("Không tìm thấy tiêu đề phim.")

    # return movie_link_all
    # All_Movie=Getlink()
    for movie in movie_link_all:
        driver.get(movie)
        sleep(2)
        page_source = BeautifulSoup(driver.page_source, 'html.parser')
        movie_title = page_source.find('div',class_='product-name').get_text(strip=True)
        movie_actor = page_source.find('div',class_='movie-director movie-info').get_text(strip=True)
        movie_director = page_source.find('div',class_='movie-actress movie-info').get_text(strip=True)
        movie_genre = page_source.find('div',class_='movie-genre movie-info').get_text(strip=True)
        movie_duration = page_source.find('div',class_='movie-release movie-info').get_text(strip=True)
        movie_time = page_source.find('div',class_='movie-actress movie-info').get_text(strip=True)
        movie_lang = page_source.find('div',class_='movie-language movie-info').get_text(strip=True)
        # movie_rate = page_source.find('div',class_='movie-rating movie-rated-web').get_text(strip=True)
        movie_rate = page_source.find('div',class_='movie-rating movie-rated-web')
        if movie_rate:
            movie_rate = movie_rate.get_text(strip=True)
        else:
            movie_rate = "No"
        # movie_details = page_source.find_all('div', class_='movie-actress movie-info')
        movie_info_tags = page_source.find_all('div', class_='movie-actress movie-info')
        movie_review_page = page_source.find('div',class_='tab-content')
        # movie_review = movie_review_page.find('div',class_='std').get_text(strip=True)
        movie_review = movie_review_page.find('div',class_='std')
        if movie_review:
            movie_review = movie_review.get_text(strip=True)
        else:
            movie_review = "No"
        for info in movie_info_tags:
            label = info.find('label').get_text(strip=True)
            content = info.find('div', class_='std').get_text(strip=True)
            
            if 'Đạo diễn:' in label:
                movie_dienvien = content
            elif 'Thời lượng:' in label:
                movie_time = f"{label} {content}"

        movie_image = page_source.find('div',class_='product-image-gallery')
        if movie_image is not None:
                posth_path = movie_image.find('img', class_='gallery-image visible')
                backgroud_path = movie_image.find('img', id = 'image-0')
            
            # Lấy giá trị của thuộc tính 'src' nếu có
                if posth_path is not None:
                    posth_src = posth_path['src']
                else:
                    posth_src = None
                
                if backgroud_path is not None:
                    backgroud_src = backgroud_path['src']
                else:
                    backgroud_src = None
        else:
            posth_src = None
            backgroud_src = None
            print("Không tìm thấy hình ảnh sản phẩm.")
        try:
            trailer_item = driver.find_element(By.CSS_SELECTOR, "li.last span")
            if trailer_item.text == "Trailer":
                trailer_item.click()
            # # Tìm và click vào nút trailer
            # Clicktrailer = WebDriverWait(driver, 10).until(
            # EC.element_to_be_clickable((By.XPATH, '//*[@id="top"]/body/div[1]/div/div[3]/div[2]/div/div[2]/div[2]/ul/li[2]'))
            # )
            # Clicktrailer.click()
            # sleep(2)  # Đợi trang cập nhật sau khi click

            # Tìm iframe và lấy thuộc tính src
            try:
                iframe = driver.find_element(By.XPATH, '//div[@class="std product_view_trailer"]/iframe')
                iframe_src = iframe.get_attribute('src')
                video_id = iframe_src.split('/embed/')[1].split('?')[0]
                print("ID video:", video_id)
            except NoSuchElementException:
                print("Không tìm thấy iframe trên trang.")
        except (NoSuchElementException, ElementClickInterceptedException) as e:
            print(f"Không thể click vào phần tử trailer: {e}")

        movie_id =n    
        movie_data = (
            movie_id,
            video_id,    #ID VIDEO
            movie_title.split(":")[-1].strip(),        
            movie_director.split(":")[-1].strip(),      
            movie_actor.split(":")[-1].strip(),        
            movie_genre.split(":")[-1].strip(),    
            movie_time.split(":")[-1].strip(),     
            movie_duration.split(":")[-1].strip(),      
            movie_lang.split(":")[-1].strip(),      
            movie_rate.split(":")[-1].strip(),        
            movie_review.split(":")[-1].strip(),       
            posth_src,         
            backgroud_src      
        )
        save_movie_now(db,movie_data)
        print(movie_id)
        print(video_id)
        print(movie_title.split(":")[-1].strip())
        print(movie_actor.split(":")[-1].strip())  #=
        print(movie_director.split(":")[-1].strip())
        print(movie_genre.split(":")[-1].strip())
        print(movie_time.split(":")[-1].strip())
        print(movie_duration.split(":")[-1].strip())
        print(movie_lang.split(":")[-1].strip())
        print(movie_rate.split(":")[-1].strip())
        print(movie_review)
        print(posth_src)
        print(backgroud_src)
        print('\n')

def Crawl():
    url = 'https://www.cgv.vn/home/'
    driver.get(url)
    # credential = open('login.txt')
    # line = credential.readlines()
    # username = line[0]
    # password =line[1]
    sleep(2)
    search_field = driver.find_element(By.XPATH, '//*[@id="cboxClose"]')
    search_field.click()
    sleep(2)
    soup = BeautifulSoup(driver.page_source, 'html.parser')
    firm =[]
    # Lấy thẻ <a> của "Phim Đang Chiếu" và "Phim Sắp Chiếu"
    now_showing = soup.find('a', string="Phim Đang Chiếu")['href']
    coming_soon = soup.find('a', string="Phim Sắp Chiếu")['href']
    firm.append(now_showing)
    firm.append(coming_soon)
    n=0
    remove_movie()
    for i in firm:
        n=n+1
        driver.get(i)
        Getlink(n)
        print('Done')

