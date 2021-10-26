import React, { useState, Component, useEffect } from 'react';
import ReactDOM from 'react-dom';
import '../CSS/Admin.css';
import { AiFillPlusCircle} from "react-icons/ai";
import { BiLoaderAlt} from "react-icons/bi";
import TimesTable from './TimesTable/TimesTable'
import TimesTableAffiche from './TimesTable/TimesTableAffiche'


const Times=()=>{
    const [levels,setLevels]=useState(false);
    const [timest,setTimest]=useState(false);
    const [idsel,setIdsel]=useState(null);
    const [add,setAdd]=useState(false);
    const [data,setdata]=useState(null);
    const getLevels=()=>{
        fetch('/api/levels/getAll').then((res)=>{return res.json();}).then((data)=>{setLevels(data);setIdsel(data[0]["id"])})
    }
    const getTimesd=()=>{
        fetch('/api/timetables/getAll').then((res)=>{return res.json();}).then((data)=>{setTimest(data);})
    }
    useEffect(()=>{
        if(levels===false ){getLevels();}
        if(timest===false ){getTimesd();}
    });
    const Ajouter=(url)=>{
        const token=document.querySelector('meta[name="csrf-token"]').getAttribute('content');
        const dataform=new FormData();
        dataform.append("levels",idsel);
        dataform.append("data",data);
        fetch(url, {
            method: 'POST',
            headers: {"X-Requested-With": "XMLHttpRequest","X-CSRF-TOKEN":token},
            body: dataform
        }).then(function(res){ return res.json();}).then(function(json) {console.log(json);if(json===true){alert('done'); setAdd(false);setLevels(false);setTimest(false)
        }
        else{alert('ll')}});

        
    }
    if(levels===false || timest===false){
        return(
        <div className="cc___time__table_cc" >
            <div className="Container_________LoadV1_______0001" >
                 <BiLoaderAlt size="45px" color="#100f87" className="loader__p____pg" />
            </div>
        </div>
        )
    }
    
    return(
       <div className="cc___time__table_cc" onClick={getTimesd()} >
           {add ?
            <div className="times___t_cc">
                <TimesTable
                    onchange={setdata}
                    Data={(timest[idsel]==null)?null:JSON.parse(timest[idsel])}
                    Days={["Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"]} 
                    Hours={["8:30-10:30","10:30-12:30","14:30-16:30","16:30-18:30"]} 
                />
                <button id="btn___addormod__tstle"  
                    onClick={()=>{Ajouter((timest[idsel]==null)?'/api/timetables/add':'/api/timetables/edit')}}>
                       {(timest[idsel]==null)? 'Ajouter' : 'Modifier'}
                </button>
            </div>
           :
           <>
            <div>
               <select onChange={(e)=>{setIdsel(e.target.value);console.log(idsel)}}>
                   {levels.map((m)=><option key={"k_"+m.id} value={m.id}  >{m.label}</option>)}
               </select>
               <button onClick={()=>{setAdd(true)}} >Modifier</button>
           </div>
           <div>
               {(timest[idsel]==null)?
                   <div className="no____tt__4l">
                        <div>
                            there is no data
                            <button onClick={()=>{setAdd(true)}} >Ajouter un emplois</button>
                        </div>
                    </div>
                    :
                    <div className="TimesTable__cc">
                        <TimesTableAffiche
                            Data={JSON.parse(timest[idsel])}
                            Days={["Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"]} 
                            Hours={["8:30-10:30","10:30-12:30","14:30-16:30","16:30-18:30"]} 
                        />
                    </div>
               }
           </div>
           </>}
       </div>
    );
}
if (document.getElementById('times')) {
    ReactDOM.render(<Times />, document.getElementById('times'));
}

{/* <TimesTable
            Days={["Lundi","Mardi",]} 
            Hours={["8:30-10:30","8:30-10:30",]} 
        />

         <TimesTableAffiche
            Data={JSON.parse('[[["01","02","03"],["00","00"]],[["21","22","23"],["33"]]]')}
            Days={["Lundi","Mardi",]} 
            Hours={["8:30-10:30","8:30-10:30",]} 
        /> */}