#!/bin/bash

# Thông tin kết nối cơ sở dữ liệu
DB_HOST="192.168.122.44"  # Ví dụ: 192.168.1.100
DB_PORT="3306"
DB_NAME="test"
DB_USER="backup_user"
DB_PASSWORD="namPhuong123@"
BACKUP_DIR="/home/namphuong1/backup"  # Thư mục để lưu sao lưu
TIMESTAMP=$(date +"%Y%m%d_%H%M")

# Tạo thư mục mới cho mỗi lần sao lưu
mkdir -p "$BACKUP_DIR/$TIMESTAMP"

# Lấy danh sách các bảng trong cơ sở dữ liệu
TABLES=$(mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "SHOW TABLES;" | awk '{ print $1 }' | grep -v '^Tables')

# Xuất từng bảng vào file CSV
for TABLE in $TABLES; do
    mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "SELECT * FROM $TABLE" \
    | sed 's/\t/,/g' > "$BACKUP_DIR/$TIMESTAMP/$TABLE.csv"
done

# Tùy chọn: Nén thư mục sao lưu để tiết kiệm dung lượng
tar -czf "$BACKUP_DIR/$TIMESTAMP.tar.gz" -C "$BACKUP_DIR" "$TIMESTAMP"
rm -rf "$BACKUP_DIR/$TIMESTAMP"  # Xóa thư mục không nén
