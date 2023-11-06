import math

def calc_sin(var, L, scale):
    sine_results = []
    results = []
    start = 1
    for i in range(start, var+1):
        sine_results.append(math.sin((2*math.pi*i)/L)*scale)

    Ax, Ay = 10, 10
    for i in range(start, var+1):
        results.append(Ax*sine_results[i-1]//scale)
    return results

print(calc_sin(20, 80, 100))