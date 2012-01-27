#!/usr/bin/python3

import time, random, math


print("Test,Initialize,Count Variance,Sort,Q10000,Total");


for a in (range(0,10)):
	array = []
	result = [10-a]
	tm_start = time.time()
	for x in (range(1000000)):
		array.append(int(math.floor(random.random()*100))) # I know there is a shortcut
	tm_end = time.time()
	result.append(tm_end - tm_start)
	tm_start = tm_end

	sum = math.fsum(array)
	variance = 0
	avg = sum / len(array);
	for x in array:
		variance += (x-avg)**2
	variance /= len(array);
	tm_end = time.time()
	result.append(tm_end - tm_start)
	tm_start = tm_end

	tmp = sorted(array)
	tm_end = time.time()
	result.append(tm_end - tm_start)
	tm_start = tm_end
	
	alen = len(array)-1
	quantiles = []
	qn = 10000
	for quantile in (range(0,qn+1)):
		alq = alen * quantile / qn
		idx = int(math.floor(alq))
		diff = alq - idx
		if diff < 0.001:
			qvalue = tmp[idx]
		else:
			qvalue = int(math.floor(tmp[idx] * (1 - diff) + tmp[idx+1] * diff +.5))
		quantiles.append(qvalue)
	tm_end = time.time()
	result.append(tm_end - tm_start)
	tm_start = tm_end

	result.append(math.fsum(result[1:]))
	print(result[0], ",".join(map(lambda x: "{:.2f}".format(x), result[1:])))
	time.sleep(0.1)

