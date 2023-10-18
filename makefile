all:
	g++ test.cpp -o generate_image
	./generate_image
	python3 image.py