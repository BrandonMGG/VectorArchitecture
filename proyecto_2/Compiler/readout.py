from PIL import Image

# Define the size of the output image
image_width = 300
image_height = 300

# Create a new blank grayscale image
image = Image.new('L', (image_width, image_height))

# Open the text file containing the binary data
with open('proyecto_2/Procesador/outfile.txt', 'r') as file:
    for y in range(image_height):
        line = file.readline().strip()  # Read a line from the text file and remove leading/trailing whitespace
        if not line:
            break  # Stop if the end of the file is reached

        for x in range(image_width):
            # Extract the last 8 bits of the line and convert to an integer
            pixel_value = int(line[-8:], 2)
            
            # Set the pixel value in the image
            image.putpixel((x, y), pixel_value)

# Save the resulting grayscale image
image.save('output_image.png')

# Display the image (optional)
image.show()
