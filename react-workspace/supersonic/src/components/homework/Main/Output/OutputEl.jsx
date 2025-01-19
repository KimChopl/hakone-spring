import { ImageCover, ImageInnerCover, Images } from "./Output.Style";

const Output = (props) => {
    return (
        <div>
                {
                    props.imgList.map((e) => {
                        return (
                            <ImageCover>
                                <ImageInnerCover>
                                    <Images src={e.src} alt={e.alt} />
                                </ImageInnerCover>
                                <div>
                                    <label>{e.date}</label>
                                </div>
                            </ImageCover>
                        );
                    })
                }
            </div>
    )
};
export default Output;
