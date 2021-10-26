function loading(){$(".loading-container").fadeOut(300);}
$("#copyrightIntroduction").hover(function(){
        swal({
          title: "This project is made by :",
          text: "Omar Ezzarqtouni\nTayeb Hamdaoui\nNawal Ait Ahmed\nNisrine Amghar\nMohammed Amine Ayache",
          button: "Nice to meet you!",
        });
},function(){
    $("#copyrightIntroductionModal").modal("hide");
});
$(".year").text((new Date()).getFullYear());
$("#toTheTop").click(function(){
    $(this).addClass("shaking");
    setTimeout(function(){
        document.body.scrollTop = 0;
        document.documentElement.scrollTop = 0; 
    },200);
});
    if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
        $("#toTheTop").css("display","block");
      } else {
        $("#toTheTop").removeClass("shaking");
        $("#toTheTop").css("display","none");
      }
window.onscroll = function() {
    if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
        $("#toTheTop").css("display","block");
      } else {
        $("#toTheTop").removeClass("shaking");
        $("#toTheTop").css("display","none");
      }
};
/*********************************** Logical **************************************/
	var LeftNavOpen=true;
    var LeftNavOpenMenu=true;
    var HoverTranstion=false;
    var HoverTranstionLeave=false;
    var Search=null;
	
	function mobileView()
	{
		let LeftNav=document.getElementsByClassName('container_____adminPage')[0];
        let TextLeftNav=document.getElementsByClassName('Text________NavBar_______Left');
        let AdminCaontainer=document.getElementById('AdminCaontainer');
        if(!window.matchMedia("(max-width: 900px)").matches){
            LeftNav.style.left=0;
            HoverTranstion  = false;HoverTranstionLeave = false;LeftNavOpen = true;
            LeftNav.style.width='230px';
            AdminCaontainer.style.marginLeft="250px";
            for(let i=0;i<TextLeftNav.length;i++){
                TextLeftNav[i].style.opacity=1;
                TextLeftNav[i].style.display='block';
            }
            LeftNavOpenMenu = true ;
        }
        else{
            document.getElementsByClassName('container_____adminPage')[0].style.left='-300px';
            AdminCaontainer.style.marginLeft=0;
            LeftNavOpenMenu = true ;LeftNavOpen  = true ;
        }
	}
$(document).ready(()=>{
	const Onpress=()=>{
        document.getElementById("search_____res___topBar").style.display="none";
        if(!window.matchMedia("(max-width: 900px)").matches) {
            let LeftNav=document.getElementsByClassName('container_____adminPage')[0];
            let TextLeftNav=document.getElementsByClassName('Text________NavBar_______Left');
            let AdminCaontainer=document.getElementById('AdminCaontainer');
            LeftNav.style.left=0;
            if(!LeftNavOpenMenu){
                LeftNav.style.left='0';
                LeftNavOpenMenu = true;
            }
            if(LeftNavOpen){
                    document.getElementById("img____part1___navb").style.display="none";
                    for(let i=0;i<TextLeftNav.length;i++){
                        TextLeftNav[i].style.opacity=0;
                        TextLeftNav[i].style.display='none';
                    }
                    LeftNav.style.width='55px';
                    AdminCaontainer.style.animationName="MarginLeftAIn";
                    AdminCaontainer.style.animationDuration=".5s";
                    AdminCaontainer.style.marginLeft="65px";
                    
            }
            else{
                document.getElementById("img____part1___navb").style.display="block";

                    LeftNav.style.width='230px';
                    AdminCaontainer.style.animationName="MarginLeftAOut";
                    AdminCaontainer.style.animationDuration=".5s";
                    AdminCaontainer.style.marginLeft="250px";
                    for(let i=0;i<TextLeftNav.length;i++){
                        TextLeftNav[i].style.opacity=1;
                        TextLeftNav[i].style.display='block';
                    }
            }
            LeftNavOpen = !LeftNavOpen;
        }
    };
    const OnpressMedia=()=>{
        let LeftNav=document.getElementsByClassName('container_____adminPage')[0];
        let TextLeftNav=document.getElementsByClassName('Text________NavBar_______Left');

        if(!LeftNavOpen){
            LeftNavOpen = true;
            LeftNav.style.width='230px';
            for(let i=0;i<TextLeftNav.length;i++){
                TextLeftNav[i].style.opacity=1;
                TextLeftNav[i].style.display='block';
            }
            LeftNavOpen = true;
            HoverTranstion = false;
            HoverTranstionLeave = false;
        }
        if(LeftNavOpenMenu)
                LeftNav.style.left='0px';   

        else
                LeftNav.style.left='-300px'; 

        LeftNavOpenMenu = !LeftNavOpenMenu;
    };
    const OnpressMenu=()=>{
        document.getElementById("search_____res___topBar").style.display="none";
        if(!window.matchMedia("(max-width: 900px)").matches) {
            Onpress();
            HoverTranstion = !HoverTranstion;
            HoverTranstionLeave = !HoverTranstionLeave;
            LeftNavOpenMenu = true;
            LeftNavOpenMenu = true;
        }
        else  
            OnpressMedia();
    };
	const onHideMobile = ()=>
	{
		if(window.matchMedia("(max-width: 900px)").matches){
			//$("#AdminCaontainer").click(()=>{if(LeftNavOpenMenu)OnpressMedia();});
		}
	}
	window.addEventListener("resize", ()=>{
        mobileView();
		onHideMobile();
	});
    $(".Outline_________Icon__________menu").click(OnpressMenu);
	$("backgroundHelper").click(()=>{if(!LeftNavOpenMenu)Onpress();});
	if(!LeftNavOpenMenu)
		$("backgroundHelper").css("display","flex");
	$("#Helper2").click(function(){if(!LeftNavOpenMenu)Onpress();});
	$(".container_____adminPage").hover(()=>{if(HoverTranstion&&!LeftNavOpen&&LeftNavOpenMenu)Onpress();},()=>{if(HoverTranstionLeave&&LeftNavOpen&&LeftNavOpenMenu)Onpress();});
	onHideMobile();
});