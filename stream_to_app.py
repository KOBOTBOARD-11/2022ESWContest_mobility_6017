import websockets
import asyncio
import time
import cv2, base64

portNum = 6000
print("Started server on port : ", portNum)

async def StreamServe(websocket, path):
    print("Client Connected !")
    try :
        global cap
        # 라즈베리파이의 http 스트리밍 영상 URL을 넣으세요.
        cap = cv2.VideoCapture('streamingURL')

        while cap.isOpened():
            time.sleep(0.1)
            ret, frame = cap.read()
            encoded = cv2.imencode('.jpg', frame)[1]
            data = str(base64.b64encode(encoded))
            b64Data = data[2:len(data)-1]

            await websocket.send(b64Data)

        cap.release()
    except websockets.connection.ConnectionClosed as e:
        print("Client Disconnected !")
        cap.release()
    except:
        print("Someting went Wrong !")

startServer = websockets.serve(StreamServe, port=portNum)

asyncio.get_event_loop().run_until_complete(startServer)
asyncio.get_event_loop().run_forever()

cap.release()
