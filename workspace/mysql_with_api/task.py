from crud_module import *
import hashlib
from random import randint
from sms.send_sms import send_message
from mail_module import send_email

if __name__ == '__main__':
    # 회원가입(SMS API) - 랜덤한 인증번호 6자리 발송 후 검사
    # message = "이메일: "
    # member_email = input(message)
    # # 아이디(이메일) 중복검사
    # find_by_id_query = "select email from tbl_member where email = %s"
    # find_by_id_params = member_email,
    # result = find_by_id(find_by_id_query, find_by_id_params)
    #
    # if not result:
    #     message = "비밀번호: "
    #     member_password = input(message)
    #     encryption = hashlib.sha256()
    #     encryption.update(member_password.encode('utf-8'))
    #     member_password = encryption.hexdigest()
    #
    #     message = "이름: "
    #     member_name = input(message)
    #
    #     message = "핸드폰 번호: "
    #     member_phone = input(message)
    #
    #     # DEBUG FALSE
    #     # certification_number = "".join([str(randint(0, 9))for i in range(6)])
    #     # send_message(member_phone, certification_number)
    #     # message = "인증번호: "
    #     # certification_number_input = input(message)
    #
    #     # DEBUG TRUE
    #     certification_number = "123456"
    #     message = "인증번호: "
    #     certification_number_input = input(message)
    #
    #     if certification_number_input == certification_number:
    #         save_query = "insert into tbl_member(email, password, name) values(%s, %s, %s)"
    #         save_params = (member_email, member_password, member_name)
    #         save(save_query, save_params)
    #         print(f"{member_name}님 환영합니다~!")
    # else:
    #     print("이미 사용중인 이메일입니다.")

    # 로그인 후 마이페이지로 이동
    # 회원 비밀번호 변경(EMAIL API) - 랜덤한 코드 10자리 발송 후 검사
    check_login = False
    message = "이메일: "
    member_email = input(message)
    find_by_id_query = "select email, password, name from tbl_member where email = %s"
    find_by_id_params = member_email,
    member = find_by_id(find_by_id_query, find_by_id_params)

    if member:
        message = "비밀번호: "
        member_password = input(message)
        encryption = hashlib.sha256()
        encryption.update(member_password.encode('utf-8'))
        member_password = encryption.hexdigest()

        if member.get("password") == member_password:
            print(f"{member.get('name')}님 환영합니다~!")
            for key in member:
                if key == 'password':
                    continue
                print(member.get(key))
                check_login = True

            message = "비밀번호 변경 [Y/n]: "
            check = input(message)

            if check == 'Y':
                code = "".join([chr(i + 65) for i in range(0, 26)] + [str(i) for i in range(0, 10)])
                certification_number = ""
                for i in range(10):
                    certification_number += code[randint(0, len(code))]
                send_email(member.get("email"), certification_number)
                message = f"{member.get('email')}로 인증코드를 전송했습니다.\n10자리 인증번호: "
                certification_number_input = input(message)
                if certification_number_input == certification_number:

                    message = "새로운 비밀번호: "
                    member_password = input(message)
                    message = "재입력: "
                    member_password2 = input(message)

                    if member_password == member_password2:
                        encryption = hashlib.sha256()
                        encryption.update(member_password.encode('utf-8'))
                        member_password = encryption.hexdigest()

                        update_query = "update tbl_member set password = %s where email = %s"
                        update_params = member_password, member.get("email")
                        update(update_query, update_params)

                    else:
                        print("비밀번호가 다릅니다.")

                else:
                    print("인증번호를 다시 확인해주세요.")

    if not check_login:
        print("아이디 또는 비밀번호를 다시 확인해주세요.")

    # 사용자가 입력한 한국어를 영어로 번역
    # 한국어와 번역된 문장을 DBMS에 저장
    # 번역 내역 전체 조회

    # 업로드한 이미지 파일의 이름과 이미지의 내용을 DBMS에 저장(OCR API)
    # 이미지 경로: https://thumb.mt.co.kr/06/2012/02/2012021613230156226_1.jpg/dims/optimize/
    # 경로와 추출한 텍스트 전체 조회