import React, { useState, Component, useEffect } from 'react';
import ReactDOM from 'react-dom';
import './CSS/Admin.css';
import {BrowserRouter as Router,Switch,Route, Redirect,NavLink} from "react-router-dom";
import { HiOutlineInboxIn,HiSpeakerphone,HiUsers } from "react-icons/hi";
import {BiMessageSquareDetail} from "react-icons/bi";
import {AiOutlineRead,AiFillHome} from "react-icons/ai";
import {ImBook,ImLink} from "react-icons/im";
import { RiApps2Fill,RiCoupon3Line,RiAppsFill } from "react-icons/ri";
import { ImHome3 } from "react-icons/im";
import { FaStore ,FaUser} from "react-icons/fa";
import { DiGoogleAnalytics } from "react-icons/di";
import { GiBookshelf } from "react-icons/gi";
import { TiHomeOutline } from "react-icons/ti";
import { FcCalendar } from "react-icons/fc";
import { MdSchool } from "react-icons/md";
import { BiMenu,BiSearchAlt2,BiLoaderCircle ,BiLoaderAlt} from "react-icons/bi";
import NavElement from "./NavElement";
import Accueil from "./Elements/Accueil";
import Profil from "./Elements/Profile";
import Message from "./Elements/Message";




const LoadElm=()=>{
    return(
        <BiLoaderAlt size="30px" color="white" id="refresh_______search____topLNV"/>
    )    
}
function NavBar() {
    const Month=['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
    const [LeftNavOpen,setLeftNavOpen]=useState(true);
    const [LeftNavOpenMenu,setLeftNavOpenMenu]=useState(true);
    const [HoverTranstion,setHoverTranstion]=useState(false);
    const [HoverTranstionLeave,setHoverTranstionLeave]=useState(false);
    const [Search,setSearch]=useState(null);

    window.addEventListener("resize", ()=>{
        let LeftNav=document.getElementsByClassName('container_____adminPage')[0];
        let TextLeftNav=document.getElementsByClassName('Text________NavBar_______Left');
        let AdminCaontainer=document.getElementById('AdminCaontainer');
        if(!window.matchMedia("(max-width: 900px)").matches){
            LeftNav.style.left=0;
            setHoverTranstion(false);setHoverTranstionLeave(false);setLeftNavOpen(true);
            LeftNav.style.width='230px';
            AdminCaontainer.style.marginLeft="250px";
            for(let i=0;i<TextLeftNav.length;i++){
                TextLeftNav[i].style.opacity=1;
                TextLeftNav[i].style.display='block';
            }
            setLeftNavOpenMenu(true);
        }
        else{
            document.getElementsByClassName('container_____adminPage')[0].style.left='-300px';
            AdminCaontainer.style.marginLeft=0;
            LeftNavOpenMenu(true);setLeftNavOpen(true);
        }
    });
    const Onpress=()=>{
        document.getElementById("search_____res___topBar").style.display="none";
        if(!window.matchMedia("(max-width: 900px)").matches) {
            let LeftNav=document.getElementsByClassName('container_____adminPage')[0];
            let TextLeftNav=document.getElementsByClassName('Text________NavBar_______Left');
            let AdminCaontainer=document.getElementById('AdminCaontainer');
            LeftNav.style.left=0;
            if(!LeftNavOpenMenu){
                LeftNav.style.left='0';
                LeftNavOpenMenu(true);
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
            setLeftNavOpen(!LeftNavOpen);
        }
    };
    const OnpressMedia=()=>{
        let LeftNav=document.getElementsByClassName('container_____adminPage')[0];
        let TextLeftNav=document.getElementsByClassName('Text________NavBar_______Left');

        if(!LeftNavOpen){
            setLeftNavOpen(true);
            LeftNav.style.width='230px';
            for(let i=0;i<TextLeftNav.length;i++){
                TextLeftNav[i].style.opacity=1;
                TextLeftNav[i].style.display='block';
            }
            setLeftNavOpen(true);
            setHoverTranstion(false);
            setHoverTranstionLeave(false);
        }
        if(LeftNavOpenMenu)
                LeftNav.style.left='0px';   

        else
                LeftNav.style.left='-300px'; 

        setLeftNavOpenMenu(!LeftNavOpenMenu);
    };
    const OnpressMenu=()=>{
        document.getElementById("search_____res___topBar").style.display="none";
        if(!window.matchMedia("(max-width: 900px)").matches) {
            Onpress();
            setHoverTranstion(!HoverTranstion);
            setHoverTranstionLeave(!HoverTranstionLeave);
            setLeftNavOpenMenu(true);
            setLeftNavOpenMenu(true);
        }
        else  
            OnpressMedia();
    };
    const SearchtopLNV=(e)=>{
        var sr=document.getElementById("search_____res___topBar");
        var Link=document.getElementsByClassName("Link______Element____URL ");
        if(e.target.value!=""){
            sr.style.display="flex"
            setSearch(LoadElm);
            var x=[];

            for(let i=0;i<Link.length;i++){
                var Linkel=Link[i].getElementsByClassName("Text________NavBar_______Left")[0];
                var t=Link[i].href.split("/");
                    var url="";
                    for(let i=3;i<t.length;i++){
                        url+="/"+t[i];
                    }
                if(Linkel){
                    var tx=Linkel.textContent;
                    
                    if(tx.toLowerCase().includes(e.target.value.toLowerCase()).toLowerCase)
                    x.push({"url":url,"title":tx})

                }else{
                    var tx=Link[i].textContent;
                    if(tx.toLowerCase().includes(e.target.value.toLowerCase()))
                        x.push({"url":url,"title":tx})

                }
            }
            setTimeout(() => {
                if(x.length>0){
                    var data=x.map((i,v)=><NavLink id="element_____res____search"
                    to={i["url"]} 
                    >{i["title"]}</NavLink>);
                    setSearch(data);
                }
                else{
                    setSearch(<div style={{ color:"#fff",marginTop:"3px" }}>no result !</div>);
                }
            }, 500);
        }
        else{
            sr.style.display="none"

        }
    }
    const Ac=()=>{return(<div>"lll</div>)}
    const Logo=()=>{return(<img src="/EnsahImg/LogoV1.png" id="IMG____________top_Bar" />);}
    return (
        <Router >
            <div onClick={()=>{if(!LeftNavOpenMenu)Onpress();}}  >
                <div className="container_____adminPage" onMouseEnter={()=>{if(HoverTranstion&&!LeftNavOpen&&LeftNavOpenMenu)Onpress();}} onMouseLeave={()=>{if(HoverTranstionLeave&&LeftNavOpen&&LeftNavOpenMenu)Onpress();}} >
                    <div style={{  display:"flex",alignSelf:"center",width:"165px",justifyContent:"center",paddingBottom:"25px",paddingTop:"20px",minHeight:"50px"}}>
                        <img src="/EnsahImg/Logop1.svg" style={{ width:"70%" }} id="img____part1___navb" />
                        <img src="/EnsahImg/Logop2.svg"  style={{ width:"30%" }}/>
                    </div>
                    
                    <div className="Left______Nav" style={{ overflowY:"hidden",display:'contents',height:'auto',}} >
                        <div style={{ display:'flex',position:'relative',alignItems:"center", }}>
                        <div id="search_____res___topBar">{Search}</div>
                        </div>
                        <div style={{ display:'flex',position:'relative',alignItems:"center",marginRight:"7.4px"  }}>
                                <BiSearchAlt2 color="#757575" size={25} style={{}} id="search_____icons___topBar"/>
                                <input placeholder="Search" type="text" className="search______Navbar___leftinput" onChange={(e)=>{SearchtopLNV(e)}} onFocus={(e)=>{SearchtopLNV(e)}} />        
                        </div>
                    </div>
                    <div className="Left______Nav" >
                            

                            <NavElement title="Accueil" Link={["apps/Accueil"]}  number={0} Logo={HomeAI}/>
                            <NavElement title="Mon Compte" Link={["apps/Profil"]} number={1} Logo={ProfilFa} />   
                            <NavElement title="Messages" number={2} Logo={MessagerieBI}  Link={["apps/Messages"]}/>   
                            <NavElement title="Cours et Modules" Link={["apps/MonCours","apps/Cours","apps/Questions","apps/anciensCours","apps/Modules"]} subLink={["Consulter votre cours","Consulter les cours","Questions","Cours anciens"," Consulter les modules"]} number={3} Logo={CoursAi} />   
                            <NavElement title="Application" Link={["apps/Application/Actualites","apps/Application/Affichage","apps/Application/Events"]} subLink={["Actualites","Affichage","Events"]} number={4} Logo={AppRI} />   
                            <NavElement title="Stages" Link={["apps/Stage/Offres",]}  number={5} Logo={MdStage} />  
                            <NavElement title="Bibliothèque " Link={["apps/Biblio/List",]}  number={6} Logo={Imbiblio} />
                            <NavElement title="LIENS UTILES" Link={["apps/hepfulLink",]}  number={7} Logo={HelpfullL} />   
                   
                   
                   
                    </div>
                </div>
                <div className="Top______Nav" >
                    <div className="Outline_________Icon__________menu" onClick={()=>{OnpressMenu();}} style={{ width:'25px',height:'25px',display: 'flex' ,paddingLeft:'10px' }}>
                        {Outline}
                    </div>
                </div>
                <div style={{ width:'100vw',height:'100vh',background:'#ff000000',position:'fixed',top:0,zIndex:2,display:(!LeftNavOpenMenu) ?'flex':'none',right:0 }} onClick={()=>{OnpressMenu();}}></div>

            </div>
            <Switch > 
                {/*Accueil*/}
                <Route path="/apps/Accueil" component={Accueil} />
                <Route exact path="/apps"><Redirect to="/apps/Accueil" /></Route>
                {/*Mon Compte*/}
                <Route path="/apps/Profil" component={Profil} />
                {/*Messages*/}
                <Route path="/apps/Messages" component={Message} />
                {/*Cours et Modules*/}
                <Route path="/apps/MonCours" component={Ac} />
                <Route path="/apps/Cours" component={Ac} />
                <Route path="/apps/Questions" component={Ac} />
                <Route path="/apps/anciensCours" component={Ac} />
                <Route path="/apps/Modules" component={Ac} />
                {/*Application*/}
                <Route path="/apps/Application/Actualites" component={Ac} />
                <Route path="/apps/Application/Affichage" component={Ac} />
                <Route path="/apps/Application/Events" component={Ac} />
                {/*Stages*/}
                <Route path="apps/Stage/Offres" component={Ac} />
                {/*Bibliothèque*/}
                <Route path="/apps/Biblio/List" component={Ac} />
                

            </Switch>
         
        </Router>
    );
}


//Icons
const StyleSVg={ marginRight:'10px',fontSize:'21px',marginLeft:'10px',minWidth:'19px' };

const Outline=<BiMenu size="25px" style={{ alignSelf:'center',fontSize:'25px' }} />;
const ProfilFa =<FaUser size="19px" style={StyleSVg} color="#fff"/>
const HomeAI=<ImHome3 size="19px" style={StyleSVg} color="#fff"/>;
const MessagerieBI=<BiMessageSquareDetail size="19px" style={StyleSVg} color="#fff"/>;
const AppRI=<RiAppsFill size="19px" style={StyleSVg} color="#fff"/>;
const CoursAi=<AiOutlineRead size="19px" style={StyleSVg} color="#fff"/>;
const MdStage=<MdSchool size="19px" style={StyleSVg} color="#fff"/>;
const Imbiblio=<GiBookshelf size="19px" style={StyleSVg} color="#fff"/>;
const HelpfullL=<ImLink size="19px" style={StyleSVg} color="#fff"/>;

const Marketing=<HiSpeakerphone size="16px" style={StyleSVg} color="#fff"/>;
const Store=<FaStore size="21px" style={StyleSVg} color="#fff"/>;
const analytics=<DiGoogleAnalytics size="21px" style={StyleSVg} color="#fff"/>;
const Coupons=<RiCoupon3Line size="21px" style={StyleSVg} color="#fff"/>;


export default NavBar;

if (document.getElementById('AdminCaontainer')) {
    ReactDOM.render(<NavBar />, document.getElementById('AdminCaontainer'));
}
