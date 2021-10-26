import React, { useState, Component, useEffect } from 'react';
import ReactDOM from 'react-dom';
import '../../CSS/Admin.css';
import { AiFillPlusCircle} from "react-icons/ai";
import { BsFillPlusSquareFill} from "react-icons/bs";


const TimesTable=(props)=>{

    const iniArr=(n,x,y)=>{
        var arr=new Array(n);
        for(let i=0;i<n;i++){
            arr[i]=new Array(x).fill(y);
        }
        return arr;
    }
    const iniArr1=(n,x,y)=>{
        var arr=new Array(n);

        for(let i=0;i<n;i++){
            arr[i]=onicrr(x);
        }
        return arr;
    }
    const onicrr=(x)=>{
        var arr1=new Array(x);
        for(let i=0;i<x;i++){
            arr1[i]=new Array(1);
        }
        return arr1;
    }
    const iniArr2=(n,x)=>{
        var arr=new Array(n);
        for(let i=0;i<n;i++){
            arr[i]=x[i];
        }
        return arr;
    }

    const [data,setData]=useState((props.Data!=null)?props.Data:iniArr1(props.Days.length,props.Hours.length,''));
    const [NewInp,setNewInp]=useState((props.Data!=null)?props.Data:iniArr(props.Days.length,props.Hours.length,1));

    const addinput=(k,i)=>{
        var xa=[];
        xa=NewInp;
        xa[k][i]=xa[k][i]+1;
        setNewInp(iniArr2(props.Days.length,xa));
        console.log(NewInp)
    }
    const addinput2=(k,i)=>{
        var xa=[];
        xa=NewInp;
        xa[k][i].push('');
        setNewInp(iniArr2(props.Days.length,xa));
        console.log(NewInp)
    }
    const getData=(e,k,i,n)=>{
        var xa=[];
        xa=data;
        xa[k][i][n]=e.target.value;
        setData(xa);
        props.onchange(JSON.stringify(data));
    }
    const KIinp=(k,i)=>{
        const xx=
        (new Array(NewInp[k][i]).fill(1)).map((m,n)=>
        <>
            <textarea type="text" id={"tr__t_"+k+"_"+i+"_"+n}  key={"tr__t_"+k+"_"+i+"_"+n} onChange={(e)=>{getData(e,k,i,n)}} />
        </>
        );
       
        return xx;
    }
    const KIinp2=(s,k,i)=>{
        const xx=
        s.map((m,n)=>
        <> 
                <textarea id={"tr__t_"+k+"_"+i+"_"+n}  key={"tr__t_"+k+"_"+i+"_"+n}   onChange={(e)=>{getData(e,k,i,n);}}  defaultValue={m==null ? '' : m}></textarea>
        </>
        );
        return xx;
    }

    return(
        <div style={{ width:'100%' }}>
            <table id="times____table">
                <thead>
                <tr>
                    <th style={{ background:'transparent',border:0 }}> </th>
                    {props.Hours.map((v,j)=><th key={"th"+j}>{v}</th>)}
                </tr>
                </thead>
                <tbody >
                {(props.Data==null)?
                    props.Days.map((v,k)=>
                        <tr id={"tr__t_"+k} key={"_"+k}>
                            <td className="frs___prt" style={{ textAlign:"center" }}>{props.Days[k]}</td>
                            <>
                                {
                                    props.Hours.map((s,i)=>
                                        <td id={"tr__t_"+k+"_"+i} key={"t_"+k+"_"+i}>
                                             <BsFillPlusSquareFill size="12px" color="#ddd" className="add_inp__f_t" onClick={()=>{addinput(k,i)}} />
                                             <div className="td__txt___ar__cc">
                                                {KIinp(k,i)}
                                             </div>
                                        </td>
                                    )
                                }
                            </>
                        </tr>
                    )
                    :
                    
                    NewInp.map((v,k)=>
                        <tr id={"tr__t_"+k} key={"_"+k}>
                            <td style={{ textAlign:"center" }} >{props.Days[k]}</td>
                            <>
                                {
                                    v.map((s,i)=>
                                        <td id={"tr__t_"+k+"_"+i} key={"t_"+k+"_"+i}>
                                             <BsFillPlusSquareFill size="12px" color="#ddd" className="add_inp__f_t" onClick={()=>{addinput2(k,i)}} />
                                             <div className="cont____in___tbt">
                                                {KIinp2(s,k,i)}
                                             </div>
                                        </td>
                                    )
                                }
                            </>
                        </tr>
                    )
                }
                </tbody>
                
            </table>
            
        </div>
    );
}
export default TimesTable;