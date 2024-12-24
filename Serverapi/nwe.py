'''-- *1. Bảng User*
CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- *2. Bảng Movie*
CREATE TABLE Movie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    video_id varchar(255),
    title varchar(255),
    director varchar(255),
    actors text,
    genre text,
    time_movie varchar(100),
    duration varchar(200),
    lang varchar(200),
    rating text,
    review text,
    poster_url text,
    background_url text
);

-- *3. Bảng MovieSchedule*
CREATE TABLE MovieSchedule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    show_date DATE NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES Movie(id) ON DELETE CASCADE
);

-- *4. Bảng Time*
CREATE TABLE Time (
    id INT AUTO_INCREMENT PRIMARY KEY,
    schedule_id INT,  
    show_time TIME NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES MovieSchedule(id) ON DELETE CASCADE
);

-- *5. Bảng Seat*
CREATE TABLE Seat (
    id INT AUTO_INCREMENT PRIMARY KEY,
    seat_number VARCHAR(100) NOT NULL,
    time_id INT,
    FOREIGN KEY (time_id) REFERENCES Time(id) ON DELETE CASCADE
);

-- *6. Bảng Ticket*
CREATE TABLE Ticket (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    schedule_id INT,
    time_id INT,
    seat_id INT,
    total_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movie(id) ON DELETE CASCADE,
    FOREIGN KEY (schedule_id) REFERENCES MovieSchedule(id) ON DELETE CASCADE,
    FOREIGN KEY (time_id) REFERENCES Time(id) ON DELETE CASCADE,
    FOREIGN KEY (seat_id) REFERENCES Seat(id) ON DELETE CASCADE
);
DELIMITER $$

CREATE TRIGGER add_movie_schedule
AFTER INSERT ON Movie
FOR EACH ROW
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE show_time TIME;
    DECLARE schedule_id INT;

    -- Thêm các ngày chiếu từ hôm nay đến 7 ngày tiếp theo
    WHILE i < 7 DO
        -- Tính ngày chiếu (ngày hiện tại + i ngày)
        SET @show_date = DATE_ADD(CURDATE(), INTERVAL i DAY);

        -- Thêm vào MovieSchedule và lấy schedule_id của bản ghi vừa chèn
        INSERT INTO MovieSchedule (movie_id, show_date)
        VALUES (NEW.id, @show_date);
        
        -- Lấy schedule_id của bản ghi vừa thêm vào
        SET schedule_id = LAST_INSERT_ID();

        -- Thêm các khung giờ chiếu từ 19h đến 24h cho mỗi ngày
        SET show_time = '19:00:00';
        WHILE show_time <= '24:00:00' DO
            -- Thêm vào bảng Time
            INSERT INTO Time (schedule_id, show_time)
            VALUES (schedule_id, show_time);
            
            -- Cập nhật thời gian cho lần chiếu tiếp theo (tăng 1 giờ)
            SET show_time = ADDTIME(show_time, '01:00:00');
        END WHILE;

        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER delete_seat_after_ticket
AFTER DELETE ON Ticket
FOR EACH ROW
BEGIN
    DELETE FROM Seat WHERE id = OLD.seat_id;
END$$

DELIMITER ;

'''