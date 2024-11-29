from sqlite3_to_mysql import SQLite3toMySQL

# Đường dẫn file SQLite
sqlite_file = "db.sqlite3"  # Đường dẫn đến file SQLite của bạn

# Cấu hình kết nối MySQL
mysql_config = {
    "user": "root",          # Tên người dùng MySQL
    "password": "241203",    # Mật khẩu MySQL
    "host": "localhost",     # Địa chỉ máy chủ MySQL
    "database": "nt132_database"  # Tên cơ sở dữ liệu MySQL mong muốn
}

def convert_sqlite_to_mysql():
    try:
        # Tạo đối tượng SQLite3toMySQL và thực hiện chuyển đổi
        SQLite3toMySQL(
            sqlite_file=sqlite_file,
            mysql_user=mysql_config["user"],
            mysql_password=mysql_config["password"],
            mysql_host=mysql_config["host"],
            mysql_database=mysql_config["database"]
        ).transfer()
        
        print("Chuyển đổi thành công từ SQLite sang MySQL!")
    except Exception as e:
        print("Đã xảy ra lỗi:", str(e))

if __name__ == "__main__":
    convert_sqlite_to_mysql()
