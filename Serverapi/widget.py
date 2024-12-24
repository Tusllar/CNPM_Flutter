
from datetime import datetime
from datetime import timedelta
import pandas as pd
# from crawl_cgv import Crawl
import time
def check_email(email,cursor):
    query = "select email from user where email = %s"
    cursor.execute(query,(email,))
    result = cursor.fetchone()
    if result:
        return False
    return True

def check_account(email,password,cursor):
    query = "select password from user where email = %s "
    cursor.execute(query,(email,))
    result = cursor.fetchone()
    if result:
        if result[0] == password:
            print(result[0])
            return True
        else:
            return False
    return False    

def convert_timedelta(td):
    if isinstance(td, timedelta):
        # Lấy giờ và phút từ timedelta
        hours = td.seconds // 3600  # Số giờ
        minutes = (td.seconds % 3600) // 60  # Số phút
        return f"{hours:02}:{minutes:02}"  # Trả về chuỗi 'HH:MM'
    return td  # Nếu không phải timedelta, trả về giá trị ban đầu

def check_and_run_daily():
    while True:
        # Lấy thời gian hiện tại
        now = datetime.now()
        # + timedelta(days=1)
        # Thời điểm tiếp theo để chạy (đầu ngày hôm sau)
        now.hour
        print(now.hour)
        if now.hour == 10:
            print('chyaj')
            # Crawl()
            return 1;
        else:
            print('khong chay')
            return 0;
        
       

        

