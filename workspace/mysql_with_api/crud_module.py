from s_mysql.connection_module import *


@execute
def save(cursor: Cursor, query: str, params: tuple):
    cursor.execute(query, params)


@execute
def save_many(cursor: Cursor, query: str, params: tuple):
    cursor.executemany(query, params)

@execute
def find_all(cursor: Cursor, query: str) -> list:
    cursor.execute(query)
    return cursor.fetchall()


@execute
def find_by_id(cursor: Cursor, query: str, params: tuple) -> dict:
    cursor.execute(query, params)
    return cursor.fetchone()


@execute
def update(cursor: Cursor, query: str, params: tuple):
    cursor.execute(query, params)


@execute
def delete(cursor: Cursor, query: str, params: tuple):
    cursor.execute(query, params)

@execute
def ocr_space_file(api_key, image_url):
    payload = {
        'apikey': api_key,
        'url': image_url,
        'language': 'eng'  # 언어 설정 (영어)
    }

