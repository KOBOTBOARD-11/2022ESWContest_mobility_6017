# from dotenv import load_dotenv
# import os

import websockets
import asyncio
import time
import cv2, base64

# load_dotenv()
# streamURL = os.environ.get('STREAM_URL')

portNum = 6000
print("Started server on port : ", portNum)

async def streamServe(websocket, path):
    print("Client Connected !")
    try :
        global cap
        # cap = cv2.VideoCapture(streamURL)
        cap = cv2.VideoCapture(0)

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

startServer = websockets.serve(streamServe, port=portNum)

asyncio.get_event_loop().run_until_complete(startServer)
asyncio.get_event_loop().run_forever()

cap.release()
