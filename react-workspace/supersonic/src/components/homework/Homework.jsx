import { useEffect, useState } from "react";
import styled from "styled-components";
/*
  숙제 겸 실습
  메인 컴포넌트를 하나 만들고  자식 컴포넌트로 각각 입력 모듈, 목록 출력 모듈 
  메인 컴포넌트에서 입력 및 출력을 할 수 있도록 구현

  조건)
  img태그를 사용하여 출력이 될 때 이미지도 함께 출력이 되어야함.
  option -> 능력이 된다면 JS Date를 이용하여 날짜도 함께 출력하기
*/
const Homework = () => {
    const [imgList, setImgList] = useState([
        {
            src : "a",
            alt : "a",
            date : "2024-11-28"
        },
        {
            src : "c",
            alt : "c",
            date : "2024-05-01"
        },
        {
            src : "c",
            alt : "c",
            date : "2023-09-01"
        }
    ]);
    const date = () => {
        const date = new Date();
        return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}/${date.getHours()}:${date.getMinutes()}`
    }
    const [img, setImg] = useState(null);
    const [dates, setDate] = useState(date());
    const [alt, setAlt] = useState(null);
    const sysDate = () => {
        setDate(date());
    }
    const getImgPath = (e) =>{
        const src = e.target.value
        const imgName = src.substring(src.lastIndexOf("\\") + 1)
        //console.log(imgName)
        const file = e.target.files[0];
        console.log(file)
        setAlt(imgName);
        setImg(URL.createObjectURL(file));
    }
    /*
    useEffect(() => {
        console.log(img)
    },[img])
    */
    const interval = () =>{
        setInterval(sysDate, 1000*60)
    }
    interval();
    const inputImgList = () => {
        const imgs = {src : img, alt : alt, date : dates}
        setImgList([...imgList, imgs])
    }
    /*
    const nowTime = () => {
        const dates = new Date();
        const year = dates.getFullYear();
        const month = dates.getMonth() + 1;
        const day = dates.getDay();
        const hour = dates.getHours()
        const minute = dates.getMinutes();
        setTime(`${year}-${month}-${day} ${hour}:${minute}`);
    }
    
    const settingTime = () => {
        setInterval(nowTime, 1000*60)
        console.log(nowTime)
    } // 1분이따 나옴
     */
    //settingTime();
   

    return (
        <div>
            <div>
                <div>
                    <span>{dates}</span>
                </div>
            </div>
            <div>
                {
                    imgList.map((e) => {
                        return (
                            <>
                                <div>
                                    <img src={e.src} alt={e.alt} />
                                </div>
                                <div>
                                    <label>{e.date}</label>
                                </div>
                            </>
                        );
                    })
                }
            </div>
            <div>
                <input onChange={getImgPath} type="file" />
                <button onClick={inputImgList} >Upload</button>
            </div>
        </div>
    )
};

export default Homework;
