#!/usr/bin/python2.7

import time, random, math, itertools

print("Test,Initialize,Count Variance,Sort,Q10000,Total");

for a in (range(0,10)):
	array = []
	result = [10-a]
	tm_start = time.time()
	array = [int(math.floor(random.random() * 100)) for x in xrange(1000000)]
	tm_end = time.time()
	result.append(tm_end - tm_start)
	tm_start = tm_end

	summ = sum(array)
	variance = 0
	avg = summ / len(array);
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
	for quantile in (xrange(0,qn+1)):
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

	result.append(sum(result[1:]))
	outfmt = "{:d},"+",".join(itertools.repeat("{:.3f}",len(result)-1))
	print(outfmt.format(*result))


