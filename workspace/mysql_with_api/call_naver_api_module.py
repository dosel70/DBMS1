import requests
# id : Bv9_0vus1XYI_3dFSY0u
# pw : yog6tEBH4s

import urllib.request
import json

# 업로드한 이미지 파일의 이름과 이미지의 내용을 DBMS에 저장(OCR API)
# 이미지 경로: https://thumb.mt.co.kr/06/2012/02/2012021613230156226_1.jpg/dims/optimize/
# 경로와 추출한 텍스트 전체 조회

# https://ocr.space/OCRAPI
# K82277197388957
# https://api.ocr.space/parse/imageurl?apikey=&url=
# https://api.ocr.space/parse/imageurl?apikey=&url= &language= &isOverlayRequired=true
import requests
from crud_module import *
if __name__ == '__main__':
    url = "https://api.ocr.space/parse/imageurl?apikey=K82277197388957&url=https://thumb.mt.co.kr/06/2012/02/2012021613230156226_1.jpg/dims/optimize/&language=kor&isOverlayRequired=true"
    response = requests.get(url)
    response.raise_for_status()

    result = response.json()
    # print(response.json())
    # print(type(response.json())) # 딕셔너리 but json 그 자체의 타입은 문자열 형태
    # print(type(result))
    # print(result)
    # OCR을 활용한 외부 API 사용
    text = (result['ParsedResults'][0]['ParsedText'])
    # find_all_query = "insert into tbl_img(image_name,image_content) values(%s,%s)"
    # find_all_params = ['2012/02/2012021613230156226_1',text]
    # save(find_all_query,find_all_params)
    first_item = result['ParsedResults'][0]
    # print(first_item)
    print(text)

