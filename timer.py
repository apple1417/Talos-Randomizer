import time

LOG_FILE = "D:\\SteamLibrary\\steamapps\\common\\The Talos Principle\\Log\\SeriousEditor.log"
START_LINE = "Randomizing..."
END_LINE = "Randomization Finished"

log = open(LOG_FILE)
log.read()
start_time = None
while True:
    latest_line = log.readline()[16:]
    if not latest_line:
        time.sleep(0.001)
    else:
        if not start_time:
            if latest_line.startswith(START_LINE):
                start_time = time.time()
                print("Starting timer")
        else:
            if latest_line.startswith(END_LINE):
                print(time.time() - start_time)
                start_time = None