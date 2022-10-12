from google_images_download import google_images_download

def googleImageCrawling(key, limit):
    response = google_images_download.googleimagesdownload()   #class instantiation

    arguments = {"keywords" : key, "limit" : limit, "print_urls":True,
                 "chromedriver" : "./chromedriver", "format":"jpg"}
    
    paths = response.download(arguments)   #passing the arguments to the function
    print(paths)   #printing absolute paths of the downloaded images
    
key = input("키워드 입력(복수 선정시 ',' 로 구분) : ")
limit = input("이미지 개수 입력 : ")

googleImageCrawling(key, int(limit))