#! /usr/bin/python3
import serialem as sem    

class Microscope:
    def __init__(self, port, ip, directory) -> None:
        self.port = port
        self.ip = ip
        self.directory = directory

    def connect(self):
        print(f"Try to connect SerialEM")
        sem.ConnectToSEM(self.port, self.ip)
        print(f"set dir")
        sem.SetDirectory(self.directory)
        sem.ClearPersistentVars()
        sem.AllowFileOverwrite(0)


# Arctica
c= Microscope(48888, '192.168.0.32', 'X:\\auto_screening')
c.connect()


'''
SocketServerIP                  1 192.168.0.3
SocketServerPort                1 48892
SocketServerIP                  7 192.168.0.3
SocketServerPort                7 48888
EnableExternalPython            1
'''

'''
sem.ConnectToSEM(48888, '192.168.0.32')
sem.ReportDirectory()
'''