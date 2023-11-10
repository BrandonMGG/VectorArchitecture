# Import the necessary libraries
from PIL import Image

# Define the size of the output image
image_width = 100
image_height = 100

# Create a new blank RGB image
image = Image.new('RGB', (image_width, image_height))

# Open the text file containing the binary data
with open('proyecto_2/Procesador/dataOut.txt', 'r') as file:
    for y in range(image_height):
          # Read a line from the text file and remove leading/trailing whitespace
        # Skip lines starting with "//" (comments)
        

         # Stop if the end of the file is reached
        x_a = 0
        for x in range(image_width):
            line = file.readline().strip()

            if line.startswith('//'):

                continue
            if not line:
                break 
            # Extract the first 8 bits of the line and convert to an integer
            red_value = int(line[:2],16)

            # Extract the next 8 bits of the line and convert to an integer
            green_value = int(line[2:4], 16)

            # Extract the last 8 bits of the line and convert to an integer
            blue_value = int(line[-2:], 16)

            # Set the pixel value in the image
            image.putpixel((x_a, y), (red_value, green_value, blue_value))
            x_a += 1
            

# Save the resulting RGB image
image.save('output_image.png')

# Display the image (optional)
image.show()
