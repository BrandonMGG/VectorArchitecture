# Import the necessary libraries
from PIL import Image

# Define the size of the output image
image_width = 640
image_height = 480

# Create a new blank RGB image
image = Image.new('RGB', (image_width, image_height))

# Open the text file containing the binary data
with open('proyecto_2/Procesador/outfile.txt', 'r') as file:
    for y in range(image_height):
        line = file.readline().strip()  # Read a line from the text file and remove leading/trailing whitespace
        if not line:
            break  # Stop if the end of the file is reached

        for x in range(image_width):
            # Extract the first 8 bits of the line and convert to an integer
            red_value = int(line[:8], 2)

            # Extract the next 8 bits of the line and convert to an integer
            green_value = int(line[8:16], 2)

            # Extract the last 8 bits of the line and convert to an integer
            blue_value = int(line[-8:], 2)

            # Set the pixel value in the image
            image.putpixel((x, y), (red_value, green_value, blue_value))

# Save the resulting RGB image
image.save('output_image.png')

# Display the image (optional)
image.show()
