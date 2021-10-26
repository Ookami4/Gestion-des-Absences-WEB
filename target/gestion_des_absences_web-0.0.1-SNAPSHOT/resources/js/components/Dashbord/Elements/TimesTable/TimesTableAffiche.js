import React, { useState, Component, useEffect } from 'react';
import ReactDOM from 'react-dom';
import '../../CSS/Admin.css';
import { AiFillPlusCircle} from "react-icons/ai";
import { BsFillPlusSquareFill} from "react-icons/bs";

const TimesTableAffiche=(props)=>{

    const KIinp=(s)=>{
        const xx=
        s.map((m,n)=>
        <>
            <div className="shw___d__ttbles" key={"k___shw__"+n}>{m}</div>
        </>
        );
        return xx;
    }

    return(
        <div style={{ width:'100%' }}>
            <table id="times____table">
                <thead>
                <tr>
                    <th style={{ background:'transparent',border:0  }}> </th>
                    {props.Hours.map((v,j)=><th key={"th"+j}>{v}</th>)}
                </tr>
                </thead>
                <tbody >
                {
                    props.Data.map((v,k)=>
                        <tr id={"tr__t_"+k} key={"_"+k}>
                            <td style={{ textAlign:"center" }} >{props.Days[k]}</td>
                            <>
                                {
                                    v.map((s,i)=>
                                        <td id={"tr__t_"+k+"_"+i} key={"t_"+k+"_"+i}>
                                             <div className="cont____in___tbt">
                                                {KIinp(s)}
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
export default TimesTableAffiche;