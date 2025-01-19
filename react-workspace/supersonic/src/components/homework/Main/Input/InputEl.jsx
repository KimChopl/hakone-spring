import { useState } from "react";
const Input = (props) => {
    const [img, setImg] = useState(null);
    const [alt, setAlt] = useState(null);
    const getImgPath = (e) =>{
        const src = e.target.value
        const imgName = src.substring(src.lastIndexOf("\\") + 1)
        const file = e.target.files[0];
        setAlt(imgName);
        setImg(URL.createObjectURL(file));
    }
    const inputImgList = () => {
        console.log(props.date)
        const imgs = {src : img, alt : alt, date : props.date}
        props.setImgList([...props.imgList, imgs])
    }
    return (
        <div>
            <input onChange={getImgPath} type="file" />
            <button onClick={inputImgList} >Upload</button>
        </div>
    )
};
export default Input;
