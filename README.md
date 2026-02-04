# SMART HOME MOBILE APP

The **Smart Home Mobile App** is a mobile application supported only on android for the moment.  
The main objective of the project is to provide a **centralized solution** for controlling and managing smart home appliances using a single mobile application.

The application enables users to connect to smart home devices through **Wi-Fi and Bluetooth communication technologies**, allowing real-time interaction with various appliances such as lighting systems, climate control units, and other IoT-based devices. By supporting multiple connection methods, the app ensures reliable communication with a wide range of smart home equipment.

Special attention was given to the design of a **modern, intuitive, and user-friendly interface**. The application is designed to be easy to use, enabling users to monitor and control their smart home environment efficiently without requiring advanced technical knowledge. The clean UI improves usability and enhances the overall user experience.

This project focuses on key aspects of mobile application development, including application architecture, wireless communication, and interaction with smart devices. The Smart Home Mobile App demonstrates practical implementation of smart home concepts and serves as an educational example of developing a mobile solution for home automation.

The UI includes dashboard in which you can see information about all of your devices, and optional forecast widget to notify users about the outside weather. 

<img width="466" height="1000" alt="image1" src="https://github.com/user-attachments/assets/49fd7c9f-b98c-4990-900a-96889755f5af" />
<img width="720" height="408" alt="image4" src="https://github.com/user-attachments/assets/a4397ac9-e642-4a00-b969-804ea3ba4f6e" />
<img width="720" height="466" alt="image5" src="https://github.com/user-attachments/assets/30fe63c9-669e-4087-b1ec-9767febc8c3a" />


There is also bluetooth page incldued in which the client connects to the smart device, of any kind, and sets up the wifi connection. After the wifi connection has been established the bluetooth would not be required anymore as the smart home device will create or connect to already existing local net and will start sending data to the server. The unique feature of the whole project is the device on its own has the ability to start local network by starting http server, and sets up DNS that other smart home devices already know. This allows for newly configured devices to detect if there is already local Smart Home Server and start sending data to it. The local Smart Home Server, plays the role of proxy, forwarding all incoming data to the actual remote server. This strategy removes the need for buying additional Hub device which serves only as receiver of data and does not have any smart functionality.
