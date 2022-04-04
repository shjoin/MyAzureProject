import json

from classobjectTest import Car


class Hector(Car):

    def show_state(self):
        print(f"Hector is {self.current_state} and current speed is {self.current_speed}")


if __name__ == "__main__":
    hector1 = Hector()
    hector1.start()
    hector1.show_state()
