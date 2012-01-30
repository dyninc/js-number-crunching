#!/usr/local/bin/node

function hello(iteration) {
	var array = [];
	var result = [];
	var tm_stop = 0;
	result.push(iteration);
	
	var tm_start = new Date().getTime();

	for (var i=1;i<=1E6;i++) {
		array.push(Math.floor(Math.random()*100));
	}

	tm_stop = new Date().getTime();
	result.push((tm_stop - tm_start)/1000);
	tm_start = tm_stop;

	var avg = 0;
	array.forEach(function(v){avg+=v});
	avg /= array.length;
	
	var variance = 0;
	array.forEach(function(v){ variance+=(v-avg)*(v-avg) });
	variance /= array.length;

	tm_stop = new Date().getTime();
	result.push((tm_stop - tm_start)/1000);
	tm_start = tm_stop;
	
	var tmp = array.sort(function(a,b){return a-b});
	tm_stop = new Date().getTime();
	result.push((tm_stop - tm_start)/1000);
	tm_start = tm_stop;
	
	var alen = array.length-1;
	var quantiles = [];
	for (var quantile=0;quantile<=10000;quantile++) {
		var alq = alen * quantile / 10000;
		var idx = Math.floor(alq);
		var diff = alq - idx;
		
		var qvalue =
			diff < 0.001 ?
			tmp[idx] :
			Math.floor(tmp[idx] * (1 - diff) + tmp[idx+1] * diff +.5);
		
		quantiles.push(qvalue);
	}
	tm_stop = new Date().getTime();
	result.push((tm_stop - tm_start)/1000);
	
	result.push(result[1] + result[2] + result[3] + result[4]);
	console.log(result.map(function(d,i){return i>0?d.toFixed(3):d}).join(','));
}

console.log("Test,Initialize,Count Variance,Sort,Q10000,Total");
for (var i=10;i>0;i--) hello(i);

