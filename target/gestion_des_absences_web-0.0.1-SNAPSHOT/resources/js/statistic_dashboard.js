function grapheOneLine(labels, dt, id,color,back,name) {
        if(document.getElementById(id) === null)
            return null;
        var ctx = document.getElementById(id).getContext('2d');
		var thisYear = new Date().getFullYear();
        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
				datasets: [
                    {
                        label: name+" en " + parseFloat(thisYear),
                        fill: true,
                        lineTension: 0.5,
                        backgroundColor: back,
                        borderColor: color,
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: color,
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: color,
                        pointHoverBorderColor: back,
                        pointHoverBorderWidth: 2,
                        pointRadius: 1,
                        pointHitRadius: 10,
                        data: dt
                    }
                ]
            },
            options: {
                scales: {
                    yAxes: [{
                            ticks: {
                                beginAtZero: true
                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Nombre'
                            }
                        }],
                    xAxes: [{
                            scaleLabel: {
                                display: true,
                                labelString: 'Mois'
                            }
                        }]
                }
            }
        });
    }
    function grapheDougnut(labels, dt,id) 
    {
        if(document.getElementById(id) == null)
            return null;
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [
                    {
                        data: dt,
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.4)',
                            'rgba(54, 162, 235, 0.4)',
                            'rgba(255, 206, 86, 0.4)',
                            'rgba(75, 192, 192, 0.4)',
                            'rgba(153, 102, 255, 0.4)',
                            'rgba(255, 159, 64, 0.4)'
                        ],
                        hoverBackgroundColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        hoverBorderColor: "#fff"
                    }]
            }
        });
    }
    function grapheBar(labels, dt,id,colors,backs,type) {
        if(document.getElementById(id) === null)
            return null;
        var ctx = document.getElementById(id).getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [
                    {
                        fill: true,
                        lineTension: 0.5,
                        backgroundColor: backs,
                        borderColor: colors,
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "#283179",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "#283179",
                        pointHoverBorderColor: "#3bc9f1",
                        pointHoverBorderWidth: 2,
                        pointRadius: 1,
                        pointHitRadius: 10,
                        data: dt
                    }
                ]
            },
            options: {
                legend: {
                    display: false
                },
                scales: {
                    yAxes: [{
                            ticks: {
                                beginAtZero: true
                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Nombre'
                            }
                        }],
                    xAxes: [{
                            scaleLabel: {
                                display: true,
                                labelString: type
                            }
                        }]
                }
            }
        });
    }
    function duplicate(text,nbr)
    {
        let array=[];
        for(let i=0;i<nbr;i++)
            array.push(text);
        return array;
    }
    function grapheTwoLine(labels, dt, dvt,id) {
        if(document.getElementById(id) === null)
            return null;
        var ctx = document.getElementById(id).getContext('2d');
		var thisYear = new Date().getFullYear();
        var myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
				datasets: [
                    {
                        label: "Demandes traitées en " + parseFloat(thisYear),
                        fill: true,
                        lineTension: 0.5,
                        backgroundColor: "rgba(40, 49, 121, 0.4)",
                        borderColor: "#283179",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "#283179",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "#283179",
                        pointHoverBorderColor: "#3bc9f1",
                        pointHoverBorderWidth: 2,
                        pointRadius: 1,
                        pointHitRadius: 10,
                        data: dt
                    },
                    {
                        label: "Demandes non traitées en " + parseFloat(thisYear) ,
                        fill: true,
                        lineTension: 0.5,
                        backgroundColor: "rgba(255, 99, 132, 0.4)",
                        borderColor: "rgba(255, 99, 132, 1)",
                        borderCapStyle: 'butt',
                        borderDash: [],
                        borderDashOffset: 0.0,
                        borderJoinStyle: 'miter',
                        pointBorderColor: "#ebeff2",
                        pointBackgroundColor: "#fff",
                        pointBorderWidth: 1,
                        pointHoverRadius: 5,
                        pointHoverBackgroundColor: "#ebeff2",
                        pointHoverBorderColor: "#eef0f2",
                        pointHoverBorderWidth: 2,
                        pointRadius: 1,
                        pointHitRadius: 10,
                        data: dvt
                    }
                ]
            },
            options: {
                scales: {
                    yAxes: [{
                            ticks: {
                                beginAtZero: true
                            },
                            scaleLabel: {
                                display: true,
                                labelString: 'Nombre'
                            }
                        }],
                    xAxes: [{
                            scaleLabel: {
                                display: true,
                                labelString: 'Mois'
                            }
                        }]
                }
            }
        });
    }
$(document).ready(()=>{
    $.ajax({
        type:"GET",
        url:"/api/statistic/dashboard",
        async:false,
        dataType:"json",
        success:function(data)
        {
            var all = data.users.alls;
            $("#nbradmin").text(all.admin);
            $("#nbrprof").text(all.prof);
            $("#nbrstudent").text(all.student);
            $("#allprog-adm").css("width",(all.admin/all.total)*100+"%");
            $("#allprog-prf").css("width",(all.prof/all.total)*100+"%");
            $("#allprog-std").css("width",(all.student/all.total)*100+"%");
            var etat=["Vérifié","Non vérifié"];
            var value=[];
            value.push(data.users.verified.student);
            value.push(data.users.unverified.student);
            grapheDougnut(etat,value,"ee");
            value=[];
            value.push(data.users.verified.prof);
            value.push(data.users.unverified.prof);
            grapheDougnut(etat,value,"ep");
            value=[];
            value.push(data.users.verified.admin);
            value.push(data.users.unverified.admin);
            grapheDougnut(etat,value,"ea");
            etat=["Traitée","Non traitée"];
            value=[];
            value.push(data.requests_done);
            value.push(data.requests_undone);
            grapheDougnut(etat,value,"er");
            var labels = ["Janvier", "Février", "Mars", "April", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre","Decembre"];
            var values = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            data.usersByMonth.forEach(function(d){
               values[parseInt(d.month)-1]+=d.total; 
            });
            grapheOneLine(labels,values,"usersgraph","#283179","rgba(40, 49, 121, 0.4)","Utilisateurs");
            values = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            data.coursesByMonth.forEach(function(d){
               values[parseInt(d.month)-1]+=d.total; 
            });
            grapheOneLine(labels,values,"coursesgraph","#ff3f67","rgba(255, 99, 132, 0.4)","Cours");
            values = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            var values2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
            data.requestsByMonth.forEach(function(d){
               values[parseInt(d.month)-1]+=d.total; 
            });
            data.requestsByMonthN.forEach(function(d){
               values2[parseInt(d.month)-1]+=d.total; 
            });
            grapheTwoLine(labels,values,values2,"requestsLine");
            //grapheOneLine(labels,values,"requestsLine","#fd7e14","#ffd5b3","Demandes");
            var labelsBar=[];
            var valuesBar=[];
            data.courses.profs.forEach(function(d){
                labelsBar.push(d.prof);
                valuesBar.push(d.total);
            });
            var len = data.courses.profs.length;
            grapheBar(labelsBar,valuesBar,"coursesprof",duplicate('rgba(255, 99, 132, 0.4)',len),duplicate('rgba(255, 99, 132, 1)',len),"Professeurs");
            labelsBar=[];
            valuesBar=[];
            data.courses.students.forEach(function(d){
                labelsBar.push(d.student);
                valuesBar.push(d.total);
            });
            len = data.courses.students.length;
            grapheBar(labelsBar,valuesBar,"coursesstudent",duplicate('rgba(54, 162, 235, 1)',len),duplicate('rgba(54, 162, 235, 0.4)',len),"Etudiants");
            $("#coursesNBR").text(data.courseNum);
            $("#internshipNBR").text(data.internship);
            $("#announcementNBR").text(data.annonces);
            $("#requestsNBR").text(data.requests_undone+data.requests_done);
            $("#requestsTypeNBR").text(data.request_type);
        },
        error:function(xhr)
        {
            console.log(xhr.responseText);
        }
    });
});