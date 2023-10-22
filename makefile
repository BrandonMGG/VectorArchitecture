all:
	g++ test.cpp -o generate_image -march=native
	./generate_image
	python3 image.py