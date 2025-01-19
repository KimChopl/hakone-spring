import { useState } from "react";
import Output from "./Output/OutputEl";
import Input from "./Input/InputEl";
import { MainDiv, Times } from "./Main.Style";
const Main = () => {
    const [imgList, setImgList] = useState([
            {
                src : "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAxODA1MjhfMjI4%2FMDAxNTI3NDg3NzI2OTM4.KrIJDsaZMSVcowCRN-SJVqvKibbVtomZC9SknsKEjP4g.EFXhIJl9taPwMeFDOtyFIG4KrQ8ZHXJN392p-abZf8Ag.JPEG.jjpure9999%2F%25BD%25E6%25B3%25D7%25C0%25CF01.jpg&type=a340",
                alt : "a",
                date : "2024-11-28"
            },
            {
                src : "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMzA4MTJfMTc1%2FMDAxNjkxODQwOTM1MzI5.R3KJe6_n94XPSXL72cWz3XkJWXTY6w9gV4vDioUkCh0g.2QQ-fvuNA_18O6J31h_4CNxpBXbcf7jFC5jlau3Nl7wg.PNG.hellen0502%2F%25C7%25D1%25B1%25B9%25B4%25EB%25C7%25D0%25BB%25FD%25C0%25CE%25C0%25E7%25C7%25F9%25C8%25B8_16.png&type=a340",
                alt : "c",
                date : "2024-05-01"
            },
            {
                src : "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTEwMjJfMjkx%2FMDAxNjM0ODk0NTQ0ODE3.qdH-W8bFLLUgCJPq14CqQ36MECyCjyeF1f-r8cdzH-Ig.on0iFyBvgCR3F28zlD3_DHiO5eToZXGJla9MNL1vUTMg.JPEG.rkdrudanr3841%2F20210807_155334.jpg&type=a340",
                alt : "c",
                date : "2023-09-01"
            }
        ]);
        const date = () => {
            const date = new Date();
            return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}/${date.getHours()}:${date.getMinutes()}`
        }
        const [dates, setDate] = useState(date());
        
        const sysDate = () => {
            setDate(date());
        }
        
        const interval = () =>{
            setInterval(sysDate, 1000)
        }
        interval();
        return (
            <MainDiv>
                <Times>
                    <span>현재 시각 : <strong>{dates}</strong></span>
                </Times>
                <Output imgList={imgList}/>
                <Input date={dates} imgList={imgList} setImgList={setImgList}/>
            </MainDiv>
        )
};
export default Main;
