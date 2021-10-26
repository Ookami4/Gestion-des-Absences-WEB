import React, { useState,  } from 'react';
import './CSS/Admin.css';
import {BrowserRouter as Router,Switch,Route,NavLink,Link,useLocation} from "react-router-dom";
import { TiChevronLeft } from "react-icons/ti";
import { FaRegCircle,FaRegDotCircle } from "react-icons/fa";

const NavElement=(props)=>{
    const[active,setActive]=useState(false);
    const[activeLink,setActiveLink]=useState(null);
    const subLink=()=>{
        let otherLink;
        if( props.subLink==null)  return ;
        if(props.Link.length>0 && props.subLink.length==props.Link.length) {
            const Arr=props.subLink;
            const SubLink=Arr.map( 
                (k,i)=><div className="Link______Element____eje" >
                    {(i==activeLink && active )  ? PointedCIRCLE : VideCIRCLE}
                        <NavLink   to={'/'+props.Link[i]}  tag={Link} strict 
                        isActive={(match, location) => {
                            let a=location.pathname.substring(1);
                           

                            if(!props.Link.includes(a)) setActive(false);
                            if (match==null) {
                                if(props.otherLink!=null) {
                                    
                                    var cx=false;
                                    for(let x in props.otherLink[k]){
                                        if(a.includes(props.otherLink[k][x])) {cx=true;}
                                        console.log(a.includes(props.otherLink[k]))
                                    }
                                    if(cx){
                                     setActive(true);setActiveLink(i);
                                    }
                                }
                                return false;
                            } 
                            setActive(true);setActiveLink(i);
                            


                        
                    }}
                         className={"Link______Element____URL Text________NavBar_______Left"} style={{ color:(active && i==activeLink)? 'white':'#ffffffe3',width:"80%",overflow:"hidden" ,paddingBottom:'5px'}}  >{k}</NavLink>
                     </div>);
            return SubLink;            
        }
        return null;
        
    }   
    
    const Onpress=()=>{
      let a=document.getElementsByClassName("NavElementTitle____subLink____title");
      let ide=document.getElementById("subLink___table___"+props.number);
      let svg=document.getElementsByClassName("BsFillCaretLeftFill___Svg"+props.number)[0];

      if(ide.style.maxHeight==''){
        a[props.number].style.background='#cccccc36';
        a[props.number].style.color='white';
        ide.style.maxHeight=props.Link.length*25+"px";
        svg.style.transform="rotate(-90deg)"
        
      }
      else{
        a[props.number].style.background='transparent';
        a[props.number].style.color='#ffffffe3';
        ide.style.maxHeight='';
        svg.style.transform="rotate(0deg)";
      }
    
    }
    const OneLink=(props.subLink==null);
    return(
        <div>
            {OneLink?
            <div className={active ? "NavElementTitle____subLink____title subLink____active":"NavElementTitle____subLink____title"} >
                <NavLink   to={'/'+props.Link[0]}  tag={Link} strict
                        isActive={(match, location) => {
                            let a=location.pathname.substring(1);
                            if(!props.Link.includes(a)) setActive(false);
                            if (match==null) {return false; } setActive(true);
                        
                    }}
                         className={"Link______Element____URL "} style={{ color:active ? 'white':'#ffffffe3' ,display:'flex',alignItems:"center"}}  >
                             {props.Logo}
                             <div className="Text________NavBar_______Left" style={{ paddingBottom:'2px' }}> {props.title}</div>
                             </NavLink>
            </div>  
            :
            <div className={active ? "NavElementTitle____subLink____title subLink____active":"NavElementTitle____subLink____title"} onClick={()=>{Onpress()}}>
                <div class="NavElementTitle____subLink____titleContainer" >
                    {props.Logo}
                   <div className="Text________NavBar_______Left" style={{ width:"80%",overflow:"hidden",paddingBottom:'5px' }}> {props.title}</div>
                    <TiChevronLeft style={{float:'right',position:'absolute',right:'5px'}} className={"BsFillCaretLeftFill___Svg Text________NavBar_______Left BsFillCaretLeftFill___Svg"+props.number}/>
                </div>  
            </div>}
            <div className="NavElementTitle____subLink___table" id={"subLink___table___"+props.number}  >
                    {subLink()}
                </div>
        </div>
    );
}
const VideCIRCLE=<FaRegCircle style={{ marginLeft:'18px',marginRight:'8px',maxWidth:'13px',minWidth:'13px'}} size="13px"/>
const PointedCIRCLE=<FaRegDotCircle style={{ color:'white',marginLeft:'18px',marginRight:'8px',maxWidth:'13px',minWidth:'13px'}}size="13px"  />
export default NavElement;