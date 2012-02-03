#include <stdio.h>
#include <math.h>
#include <sys/time.h>
#include <stdlib.h>


// I'm not a C coder

double timediff(struct timeval *t2, struct timeval *t1) {
	long int diff = (t2->tv_usec + 1000000 * t2->tv_sec) - (t1->tv_usec + 1000000 * t1->tv_sec);
	return diff/1E6;
}

// optimized quicksort variant, from public domain work at alienryderflex.com/quicksort/

//  This public-domain C implementation by Darel Rex Finley.
//
//  * Returns YES if sort was successful, or NO if the nested
//    pivots went too deep, in which case your array will have
//    been re-ordered, but probably not sorted correctly.
//
//  * This function assumes it is called with valid parameters.
//
//  * Example calls:
//    quickSort(&myArray[0],5); // sorts elements 0, 1, 2, 3, and 4
//    quickSort(&myArray[3],5); // sorts elements 3, 4, 5, 6, and 7

int quickSort(int *arr, int elements) {
	#define  MAX_LEVELS  1000

	int  piv, beg[MAX_LEVELS], end[MAX_LEVELS], i=0, L, R;
	beg[0]=0; end[0]=elements;

	while (i>=0) {
		L=beg[i]; R=end[i]-1;
		if (L<R) {
			piv=arr[L]; if (i==MAX_LEVELS-1) return 0;
			while (L<R) {
				while (arr[R]>=piv && L<R) R--; if (L<R) arr[L++]=arr[R];
				while (arr[L]<=piv && L<R) L++; if (L<R) arr[R--]=arr[L];
			}
			arr[L]=piv; beg[i+1]=L+1; end[i+1]=end[i]; end[i++]=L;
		} else {
			i--;
		}
	}

	return 1;
}



int main() {
	printf("Test,Initialize,Count Variance,Sort,Q10000,Total\n");

	int iterations, i;
	for (iterations = 10; iterations > 0; iterations--) {
		int arraylength = (int)1E6;

		double result[5] = {0};
		struct timeval tm_stop;
		result[0] = iterations;

		struct timeval tm_start;
		gettimeofday(&tm_start, NULL);

		int array[arraylength];
		for (i=0;i<arraylength;i++) {
			array[i] = rand()%100;
		}

		gettimeofday(&tm_stop, NULL);
		result[1] = timediff(&tm_stop, &tm_start);
		tm_start = tm_stop;

		int sum = 0;
		for (i=0; i < arraylength; i++)
			sum+=array[i];

		double avg = sum/arraylength;
		double variance = 0;
		for (i=0;i<arraylength;i++) variance+=(array[i]-avg)*(array[i]-avg);
		variance /= arraylength;

		gettimeofday(&tm_stop, NULL);;
		result[2] = timediff(&tm_stop, &tm_start);
		tm_start = tm_stop;
		
		int tmp[arraylength];
		for (i=0;i<arraylength;i++) tmp[i] = array[i];
		quickSort(tmp, arraylength);
		
		gettimeofday(&tm_stop, NULL);;
		result[3] = timediff(&tm_stop, &tm_start);
		tm_start = tm_stop;
		
		int alen = arraylength-1;
		int quantiles[10001] = {0};
		int quantile;
		for (quantile=0;quantile<=10000;quantile++) {
			double alq = 1.0 * alen * quantile / 10000;
			int idx = (int)floor(alq);
			double diff = alq - idx;
			
			if (diff < 0.001) {
				quantiles[quantile] = tmp[idx];
			} else 
				quantiles[quantile] = (int)floor(tmp[idx] * (1 - diff) + tmp[idx+1] * diff +.5);
		}
		gettimeofday(&tm_stop, NULL);;
		result[4] = timediff(&tm_stop, &tm_start);

		printf("%d,%.3f,%.3f,%.3f,%.3f,%.3f\n", 
		           (int)result[0],
		           result[1], result[2], result[3], result[4],
		           result[1] + result[2] + result[3] + result[4]);
	}
	return 0;
}
