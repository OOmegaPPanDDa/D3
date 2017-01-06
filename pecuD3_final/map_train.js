function to_map_train(){  

  var width = 1600;
  var height = 900;
  var margin = {top:20};


  d3.csv('https://raw.githubusercontent.com/OOmegaPPanDDa/D3/master/pecuD3_final/2014_train_year_flow.csv',function(stop_data){


    var projection = d3.geo.mercator()
      .scale(9000) // �؈D�Ŵ����
      .center([120.9, 24.1]) // ָ���؈D�������c(longitude(��), latitude(��))
      .translate([width / 2, height / 2]); // �������c�Ƅ�ָ����px(x, y)

    // ���� d3.geo.path ���Y���D�Q�� SVG Path
    var path = d3.geo.path().projection(projection);

    var svg = d3.select(".b02705027_map_train").append("svg")
              .attr("width", width)
              .attr("height", height);



    // Draw TW

    // console.log(topodata);

    var features = topojson.feature(topodata, topodata.objects["county"]).features;

    svg.selectAll("path").data(features).enter()
    .append("path").attr("d",path);

    for(i=features.length - 1; i >= 0; i-- ) {
      features[i].properties.color_assign = (Math.random() * 100);
      // console.log(features[i].properties.color_assign);
    };


    var color = d3.scale.category20c();
    svg.selectAll("path").data(features)
      .attr('d', path)
      .style('fill',function(d){
        return color(d.properties.color_assign)
      });



    // Draw Train Stop 

    // var s_stop_data=[];
    // var m_stop_data=[];
    // var l_stop_data=[];
    // l_i = 0;
    // m_i = 0;
    // s_i = 0;



    for(i=0;i<stop_data.length;i++){

      stop_data[i]=[projection([stop_data[i].long,stop_data[i].lat]),stop_data[i].yearFlow];


      // if(i<40){
      //   l_stop_data[l_i]=[projection([stop_data[i].long,stop_data[i].lat]),stop_data[i].yearFlow];
      //   l_i = l_i + 1;
      // }
      // if (i>=40 && i<80){
      //   m_stop_data[m_i]=[projection([stop_data[i].long,stop_data[i].lat]),stop_data[i].yearFlow];
      //   m_i = m_i + 1;
      // } 
      // if (i>=80){
      //   s_stop_data[s_i]=[projection([stop_data[i].long,stop_data[i].lat]),stop_data[i].yearFlow];
      //   s_i = s_i + 1;
      // }
    };
    

    var radius = d3.scale.sqrt()
      .domain([0, 5e7])
      .range([0, 25]);



    svg.selectAll("circle")
      .data(stop_data).enter()
      .append("circle")
      .each(function (d, i) {
            if (i <= 40) {
              // put all your operations on the second element, e.g.
              d3.select(this)
              .attr("cx", function (d) { console.log(d[0][0]); return d[0][0]; })
              .attr("cy", function (d) { return d[0][1]; })
              .attr("fill", "red")
              .transition()
              .duration(30000)
              .attr('r', function (d) { return radius(d[1])} )
              .attr('fill-opacity', 0.8);    
            }
            else if (i = 180) {
              // put all your operations on the second element, e.g.
              d3.select(this)
              .attr("cx", function (d) { console.log(d[0][0]); return d[0][0]; })
              .attr("cy", function (d) { return d[0][1]; })
              .attr("fill", "orange")
              .transition()
              .duration(20000)
              .attr('r', function (d) { return radius(d[1])} )
              .attr('fill-opacity', 0.8);    
            }
            else{
              // put all your operations on the second element, e.g.
              d3.select(this)
              .attr("cx", function (d) { console.log(d[0][0]); return d[0][0]; })
              .attr("cy", function (d) { return d[0][1]; })
              .attr("fill", "black")
              .transition()
              .duration(10000)
              .attr('r', function (d) { return radius(d[1])} )
              .attr('fill-opacity', 0.8);    

            }
          });
      




    // svg.selectAll("circle")
    //   .data(s_stop_data).enter()
    //   .append("circle")
    //   .attr("cx", function (d) { console.log(d[0][0]); return d[0][0]; })
    //   .attr("cy", function (d) { return d[0][1]; })
    //   .attr("fill", "black")
    //   .transition()
    //   .duration(1000)
    //     .attr('r', function (d) { return radius(d[1])} )
    //     .attr('fill-opacity', 0.8);  



    // svg.selectAll("circle")
    //   .data(m_stop_data).enter()
    //   .append("circle")
    //   .attr("cx", function (d) { console.log(d[0][0]); return d[0][0]; })
    //   .attr("cy", function (d) { return d[0][1]; })
    //   .attr("fill", "yellow")
    //   .transition()
    //   .duration(2000)
    //     .attr('r', function (d) { return radius(d[1])} )
    //     .attr('fill-opacity', 0.8);



    // svg.selectAll("circle")
    //   .data(l_stop_data).enter()
    //   .append("circle")
    //   .attr("cx", function (d) { console.log(d[0][0]); return d[0][0]; })
    //   .attr("cy", function (d) { return d[0][1]; })
    //   .attr("fill", "red")
    //   .transition()
    //   .duration(3000)
    //     .attr('r', function (d) { return radius(d[1])} )
    //     .attr('fill-opacity', 0.8);




    svg.append("text")
    .attr("x", width / 2 )
    .attr("y", margin.top)
    .style("text-anchor", "middle")
    .text("Taiwan Train Stop YearFlow Map");


  });


}