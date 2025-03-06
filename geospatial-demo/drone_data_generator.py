import time
import random
import subprocess
import pandas as pd
from datetime import datetime, timedelta
import sys

# Read command line arguments
south_bound = float(sys.argv[1])
north_bound = float(sys.argv[2])
west_bound = float(sys.argv[3])
east_bound = float(sys.argv[4])
file_name = sys.argv[5]

drone_descriptions = ['Surveillance', 'Attack', 'Inspection', 'Survey']
points_per_drone = 300

# Dictionary to store last coordinates of drones
drone_state = {}

def generate_drone_movement_data(drone_id, start_latitude, start_longitude, start_time, num_points=500):
    movement_data = []
    current_latitude = start_latitude
    current_longitude = start_longitude
    current_time = start_time
    
    description = random.choice(drone_descriptions)

    for _ in range(num_points):
        # Random small change in latitude and longitude to simulate movement
        delta_lat = random.uniform(-0.009, 0.009)  
        delta_lon = random.uniform(-0.009, 0.009)

        # Update current position
        current_latitude += delta_lat
        current_longitude += delta_lon

        # Update timestamp (add a small time interval, e.g., 10-60 seconds)
        current_time += timedelta(seconds=1)

        # Add the point to the movement data
        movement_data.append({
            "drone_id": drone_id,
            "description": description,
            "latitude": current_latitude,
            "longitude": current_longitude,
            "timestamp": current_time.strftime("%Y-%m-%dT%H:%M:%SZ"),
            "PotentialThreat": True
        })
    
    # Update the drone state with the last known coordinates
    drone_state[drone_id] = {
        "latitude": current_latitude,
        "longitude": current_longitude,
        "timestamp": current_time.strftime("%Y-%m-%dT%H:%M:%SZ")
    }

    return movement_data


def generate_all_drones_data(num_drones=10, points_per_drone=300):
    all_drones_data = []

    for i in range(1, num_drones + 1):
        drone_id = f"drone_{i}"
        if drone_id in drone_state:
            # Resume from last known state
            last_state = drone_state[drone_id]
            start_latitude = last_state["latitude"]
            start_longitude = last_state["longitude"]
            start_time = datetime.strptime(last_state["timestamp"], "%Y-%m-%dT%H:%M:%SZ")
        else:
            # Generate a new starting point within the boundary
            start_latitude = random.uniform(south_bound, north_bound)
            start_longitude = random.uniform(west_bound, east_bound)
            start_time = datetime.now()

        # Generate movement data for this drone
        drone_movement = generate_drone_movement_data(drone_id, start_latitude, start_longitude, start_time, points_per_drone)

        all_drones_data.extend(drone_movement)

    return all_drones_data


def generate():
    new_data = generate_all_drones_data(num_drones=10, points_per_drone=points_per_drone)
    df = pd.DataFrame(new_data)
    df.to_csv(file_name, index=False)

def ingest():
    ingest_cmd = [
        "geomesa-hbase", "ingest",
        "-c", "drone",
        "-f", "drone_movement_f",
        f"{file_name}",
        "--force"
    ]
    result = subprocess.run(ingest_cmd, capture_output=True, text=True)
    print(result)

    # we need to flush hbase table to parsist the data
    flush_cmd = [
        "hbase", "shell", "flush_all_tables.hbase"
    ]
    result = subprocess.run(flush_cmd, capture_output=True, text=True)
    print(result)

# Run the generation and ingestion every 5 minutes
while True:
    generate()
    ingest()
    time.sleep(60)
