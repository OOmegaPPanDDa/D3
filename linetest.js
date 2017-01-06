function practice_linetest()
{
	var margin = {top: 20, right: 20, bottom: 30, left: 50},
    width = 800 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;


	var x = d3.scaleTime().range([0, width]);
	var y = d3.scaleLinear().range([height, 0]);
	var parseTime = d3.timeParse("%Y年");

	var ctrl = d3.select('.content').append("svg").attr("width", width + margin.left + margin.right).attr("height", height + margin.top + margin.bottom).append("g").attr("transform","translate(" + margin.left + "," + margin.top + ")");
	/* https://oomegappandda.github.io/D3/drive_dead.csv */
	d3.csv("https://raw.githubusercontent.com/OOmegaPPanDDa/D3/master/drive_dead.csv", 
		function(data)
		{
			var ln = data.length;
			console.log(data);


			data.forEach(function(d) {
	      	d.year = parseTime(d.year);
	  		});


			var maxy = d3.max(data, function(d){return d.dead;});
			var lines = d3.line().x(function(d, i){return i*width/(ln-1)}).y(function(d){return height-d.dead*(height/maxy)});
			ctrl.append('path').data([data]).attr('d', lines).attr('stroke', 'DarkMagenta').attr('fill','none');


			x.domain(d3.extent(data, function(d) { return d.year; }));
  			y.domain([0, d3.max(data, function(d) { return d.dead; })]);
			ctrl.append("g").attr("transform", "translate(0," + height + ")").call(d3.axisBottom(x));
		  	ctrl.append("g").call(d3.axisLeft(y));


		}
	);
};