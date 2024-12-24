from flask import Flask, request, jsonify
import threading
import mysql.connector
app = Flask(__name__)
from widget import check_account,check_email,convert_timedelta,check_and_run_daily

# Cấu hình kết nối MySQL
def get_db_connection():
    conn = mysql.connector.connect(
        host='localhost',  
        user='root',      
        password='Tranvantu@294',  
        database='crawl'
    )
    return conn

# lưu ghế.
@app.route('/saveseat', methods=['POST'])
def save_seat():
    data = request.get_json()
    seat_number = data['seat_number']
    time_id = data['time_id']
    print(time_id,seat_number)
    conn = get_db_connection()
    cursor = conn.cursor()
    query = 'INSERT INTO Seat (seat_number,time_id) VALUES(%s,%s)'
    cursor.execute(query,(seat_number,time_id))
    seat_id = cursor.lastrowid
    print("Seat ID:", seat_id)
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify(seat_id), 200


#Lưu vé
@app.route('/saveticket', methods=['POST'])
def saveticket():
    data = request.get_json()
    user_id = data['user_id']
    seat_id = data['seat_id']
    total_price = data ['total_price']
    # Kết nối đến cơ sở dữ liệu MySQL
    print(user_id,seat_id,total_price)
    conn = get_db_connection()
    cursor = conn.cursor()
    query = '''SELECT 
        Seat.id AS seat_id,
        Time.id AS time_id,
        Time.show_time,
        MovieSchedule.id AS schedule_id,
        Movie.id AS movie_id,
        Movie.title
    FROM Seat
    JOIN Time ON Seat.time_id = Time.id
    JOIN MovieSchedule ON Time.schedule_id = MovieSchedule.id
    JOIN Movie ON MovieSchedule.movie_id = Movie.id
    WHERE Seat.id = %s;
    '''
    cursor.execute(query,(seat_id,))
    result = cursor.fetchone()
    print(result[2])
    movie_id = result[4]
    schedule_id = result[3]
    time_id = result[1]
    query = '''INSERT INTO Ticket (user_id,movie_id,schedule_id,time_id,seat_id,total_price) 
               VALUES (%s, %s, %s, %s, %s, %s)'''
    cursor.execute(query, (user_id,movie_id,schedule_id,time_id,seat_id,total_price))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"message": "Booking saved successfully!"}), 200


# Sign In
@app.route('/signin',methods=['POST'])
def signin():
    data = request.get_json()
    email = data["email"]
    password = data["password"]
    print( email, password)
    conn = get_db_connection()
    cursor = conn.cursor()
    result = check_email(email,cursor)
    if result==False:
        ps = check_account(email,password,cursor)
        if ps:
            query = 'SELECT * FROM user WHERE email = %s'
            cursor.execute(query, (email,))
            user = cursor.fetchone()
            print(user)
            return jsonify({
                "message": "Login successfully!",
                "user": {
                    "id": user[0],
                    "fullname": user[1],
                    "email": user[2],
                    "password": user[3]  
                }
            }), 200
        else:
            return jsonify({"message": "Invalid password!"}), 401
    else:
        result = "Email not found"
        return jsonify({"message": result}), 404
# Sign Up 
@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    username = data.get("user")
    email = data.get("email")
    password = data.get("password")

    if not username or not email or not password:
        return jsonify({"message": "Missing required fields"}), 400  # Nếu thiếu thông tin yêu cầu

    conn = get_db_connection()
    cursor = conn.cursor()

    log_return = ""

    check_mail = check_email(email, cursor)
    if check_mail:
        query = '''INSERT INTO User (full_name, email, password) VALUES (%s, %s, %s)'''
        cursor.execute(query, (username, email, password))
        conn.commit()
        log_return = "Sign up success"
    else:
        log_return = "Email is already used"
        return jsonify({"message": log_return}), 409  # Mã lỗi 409 cho xung đột email

    cursor.close()
    conn.close()

    return jsonify({"message": log_return}), 200
# API để lấy thông tin booking
@app.route('/getticket', methods=['GET','POST'])
def get_booking():
    data = request.json
    id = data['id']
    print(id)
    conn = get_db_connection()
    cursor = conn.cursor()
    query = '''
        SELECT 
        t.id AS ticket_id,
        m.title AS movie_title,
        ms.show_date,
        ti.show_time,
        s.seat_number,
        t.total_price,
        m.background_url    
    FROM 
        Ticket t
    JOIN 
        Movie m ON t.movie_id = m.id
    JOIN 
        MovieSchedule ms ON t.schedule_id = ms.id
    JOIN 
        Time ti ON t.time_id = ti.id
    JOIN 
        Seat s ON t.seat_id = s.id
    WHERE 
        t.user_id =%s; 
    '''
    cursor.execute(query,(id,))
    result = cursor.fetchall()
    print(result)
    cursor.close()
    conn.close()
    bookings = []
    for row in result:
        try:
            d= row[2]
            t= row[3]
            print(row[4])
            if d:
                day_of_week = d.strftime('%a')
                day = d.strftime('%d')
                seat = row[4].split(",")
                number = len(seat)
                print(number)
            bookings.append({
                'ticket_id': row[0],
                'movie_title': row[1],
                'dates':f'{day_of_week} {day}',
                'times': convert_timedelta(row[3]),
                'seats': row[4],
                'seat_number':number,
                'totalPrice':row[5],
                'backdropPath': row[6],
            })
        except ValueError as e:
                print(f"Error parsing date: {e}")
                continue
    return jsonify(bookings), 200

# xóa vé
@app.route('/remove', methods=['POST','GET'])
def remove_booking():
    data = request.json
    id = data['id']
    conn = get_db_connection()
    cursor = conn.cursor()
    query = "DELETE FROM Ticket WHERE id = %s"
    cursor.execute(query, (id,))
    conn.commit()
    cursor.close()
    conn.close()
    return jsonify({"message": "Booking removed successfully!"}), 200


@app.route('/nowplaying',methods = ['GET'])
def nowplaying():
    conn = get_db_connection()
    cursor = conn.cursor()
    query = 'SELECT * FROM MOVIE WHERE movie_id=1'
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    movie=[]
    for row in result:
        movie.append(
            {
            'id': row[0],
            'movie_id':row[1],
            'video_id': row[2],
            'title': row[3],
            'director': row[4],
            'actors': row[5],
            'genre': row[6],
            'time_movie': row[7],
            'duration':row[8],
            'lang':row[9],
            'rating':row[10],
            'review':row[11],
            'poster_url':row[12],
            'background_url':row[13]
    
            }
        )
    return jsonify(movie),200

@app.route('/commingsoon',methods = ['GET'])
def commingsoon():
    conn = get_db_connection()
    cursor = conn.cursor()
    query = 'SELECT * FROM MOVIE WHERE movie_id=2'
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    movie=[]
    for row in result:
        movie.append(
            {
            'id': row[0],
            'movie_id':row[1],
            'video_id': row[2],
            'title': row[3],
            'director': row[4],
            'actors': row[5],
            'genre': row[6],
            'time_movie': row[7],
            'duration':row[8],
            'lang':row[9],
            'rating':row[10],
            'review':row[11],
            'poster_url':row[12],
            'background_url':row[13]
    
            }
        )
    return jsonify(movie),200

# Lấy ngày chiếu
@app.route('/getdate', methods=['POST','GET'])
def date():
    data = request.json
    id = data['id']
    print(id)
    conn = get_db_connection()
    cursor = conn.cursor()
    query = '''
    SELECT * 
    FROM MovieSchedule
    WHERE movie_id = %s;
    '''
    cursor.execute(query,(id,))
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    date=[]
    for i in result:
            print(f"show_date: {i[2]}")
            print(id)
            try:
                show_date = i[2] 
                if show_date:
                    day_of_week = show_date.strftime('%a')
                    day = show_date.strftime('%d')
                date.append({
                    'id': i[0],
                    'movie_id': i[1],
                    'date': f'{day_of_week} {day}',  
                })
            except ValueError as e:
                print(f"Error parsing date: {e}")
                continue
    print(date)
    return jsonify(date), 200

# Time Schedule
@app.route('/gettime', methods=['POST','GET'])
def time():
    data = request.json
    id = data['id']
    conn = get_db_connection()
    cursor = conn.cursor()
    query = '''
    SELECT * 
    FROM Time
    WHERE schedule_id = %s;
    '''
    cursor.execute(query,(id,))
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    dates=[]
    for i in result:
            try:
               
                dates.append({
                    'id': i[0],
                    'movie_id': i[1],
                    'time': convert_timedelta(i[2]),  
                })
            except ValueError as e:
                print(f"Error parsing date: {e}")
                continue
    print(dates)      
    return jsonify(dates), 200
    

#Get Seat 
@app.route('/seat', methods=['POST','GET'])
def seat():
    data = request.json
    id = data['id']
    conn = get_db_connection()
    cursor = conn.cursor()
    query = '''
    SELECT * 
    FROM Seat
    WHERE time_id =%s;
    '''
    cursor.execute(query,(id,))
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    booked_seats = set() 
    for row in result:
        dates = row[1].split(',')  
        booked_seats.update([seat.strip() for seat in dates]) 
    
    seats = [{'seats': list(booked_seats)}]
    print(booked_seats)      
    return jsonify(seats), 200


# 
@app.route('/search',methods=['GET'])
def search_by_title_realtime():
    name = request.args.get("q", "")
    conn = get_db_connection()
    cursor = conn.cursor()
    query = '''Select * from movie '''
    cursor.execute(query)
    resulf = cursor.fetchall()
    movie=[]
    for row in resulf:
        movie.append(
                {
                'id': row[0],
                'movie_id':row[1],
                'video_id': row[2],
                'title': row[3],
                'director': row[4],
                'actors': row[5],
                'genre': row[6],
                'time_movie': row[7],
                'duration':row[8],
                'lang':row[9],
                'rating':row[10],
                'review':row[11],
                'poster_url':row[12],
                'background_url':row[13]
        
                }
            )
        # Tìm kiếm và hiển thị kết quả
    results = [movie for movie in movie if name.lower() in movie['title'].lower()]       
        
        # Xóa màn hình (tùy chọn, để làm mới giao diện)
        # print("\033[H\033[J", end="")  # Lệnh xóa màn hình trong terminal (Linux/Mac/Windows hỗ trợ ANSI)

    print(f"Tìm kiếm: '{name}'")
    if results:
        print(f"Tìm thấy {len(results)} phim:")
        for i, movie in enumerate(results, 1):
            print(movie)
            print('\n')
    
    else:
        print("Không tìm thấy phim nào.")
    return jsonify(results),200


@app.route('/checkmail',methods=['POST','GET'])
def checkmail():
    data = request.json
    email = data['email']
    conn = get_db_connection()
    cursor = conn.cursor()
    query = '''Select * from user where email = %s '''
    cursor.execute(query,(email,))
    resulf = cursor.fetchone()
    if resulf:
       return jsonify({'message':'Email tồn tại'}),200
             
    return jsonify({'message':'Email không tồn tại'}),400
    
@app.route('/resetpass',methods=['POST','GET'])
def resetpass():
    data = request.json
    email = data['email']
    password = data['password']
    conn = get_db_connection()
    cursor = conn.cursor()
    query = '''UPDATE user SET password = %s WHERE email = %s '''
    cursor.execute(query,(password,email))
    conn.commit()
    return jsonify({'message':'Reset thành công'}),200
    
   


if __name__ == '__main__':
    check_and_run_daily()
    # daily_task_thread = threading.Thread(target=check_and_run_daily)
    # daily_task_thread.daemon = True  # Đảm bảo luồng này dừng khi chương trình chính dừng
    # daily_task_thread.start()
    app.run(debug=True,port=80,host='0.0.0.0')
