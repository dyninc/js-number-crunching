import java.util.*;
import java.lang.Thread;

public class JavaStats {
	public static void main(String[] args) {
		System.out.format("Test,Initialize,Count Variance,Sort,Q10000,Total\n");

		for (int iterations = 10; iterations > 0; iterations--) {
			int[] array = new int[1000000];
			double[] result = new double[5];
			long tm_stop = 0;
			result[0] = iterations;
			
			int arraylength = (int)1E6;
			
			long tm_start = System.currentTimeMillis();
			for (int i=0;i<arraylength;i++) {
				array[i] = (int)Math.floor(Math.random()*100);
			}
	
			tm_stop = System.currentTimeMillis();
			result[1] = (tm_stop - tm_start)/1000.0;
			tm_start = tm_stop;
			
			int sum = 0;
			for (int i=0; i < arraylength; i++)
				sum+=array[i];
			
			double avg = sum/arraylength;
			double variance = 0;
			for (int v: array) variance+=Math.pow(v-avg,2);
			variance /= arraylength;
    
			tm_stop = System.currentTimeMillis();
			result[2] = (tm_stop - tm_start)/1000.0;
			tm_start = tm_stop;
			
			int[] tmp = new int[arraylength];
			System.arraycopy(array, 0, tmp, 0, array.length);
			Arrays.sort(tmp);
			
			tm_stop = System.currentTimeMillis();
			result[3] = (tm_stop - tm_start)/1000.0;
			tm_start = tm_stop;
			
			int alen = arraylength-1;
			int[] quantiles = new int[10001];
			for (int quantile=0;quantile<=10000;quantile++) {
				double alq = 1.0 * alen * quantile / 10000;
				int idx = (int)Math.floor(alq);
				double diff = alq - idx;
				
				if (diff < 0.001) {
					quantiles[quantile] = tmp[idx];
				} else 
				    quantiles[quantile] = (int)Math.floor(tmp[idx] * (1 - diff) + tmp[idx+1] * diff +.5);
			}
			tm_stop = System.currentTimeMillis();
			result[4] = (tm_stop - tm_start)/1000.0;
		
			System.out.format("%d,%.3f,%.3f,%.3f,%.3f,%.3f\n", (int)result[0], 
			                                              result[1], result[2], result[3], result[4],
			                                              result[1] + result[2] + result[3] + result[4]
			);
		}
	}
}
