#  Nama File: consumer.py
#  Deskripsi: File ini berfungsi untuk menangani channel notifikasi websocket maupun fcm 
#  Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
#  Tanggal: Dec 20, 2024

import json
from channels.generic.websocket import AsyncWebsocketConsumer

class NotificationConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        # Bergabung ke grup WebSocket
        await self.channel_layer.group_add("notifications", self.channel_name)
        print(f"WebSocket connected: {self.channel_name}")
        await self.accept()

    async def disconnect(self, close_code):
        # Keluar dari grup WebSocket
        await self.channel_layer.group_discard("notifications", self.channel_name)

    async def send_notification(self, event):
        # Kirim pesan ke WebSocket
        message = event["message"]
        await self.send(text_data=json.dumps({
            "message": message
        }))
