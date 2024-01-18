import pymysql
from pymysql.cursors import Cursor


def connect():
    conn = pymysql.connect(host='3.38.208.74', user='mysql', password='1234', db='test',
                           charset='utf8', autocommit=False)
    cursor = conn.cursor(pymysql.cursors.DictCursor)
    return conn, cursor

# crud : save, find_all, find_by_id,update, delete 중 하나가 들어온다.
def execute(crud):
    result = None

    def manage(*args):

        nonlocal result

        # 연결 객체와 커서 객체를 받아온다.
        conn, cursor = connect()

        try:
            # crud 함수 실행, cursor 객체를 전달해줌으로써, 해당 쿼리가 실행되도록 한다.
            result = crud(cursor, *args)
            conn.commit()

        except Exception as e:
            print(e.__str__())
            conn.rollback()
        finally: # 무조건 닫아라 그 이후 값들을 보여줘라
            cursor.close()
            conn.close()
        return result

    return manage