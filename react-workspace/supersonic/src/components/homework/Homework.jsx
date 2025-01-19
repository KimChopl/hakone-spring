import Main from "./Main/Main";

/*
  숙제 겸 실습
  메인 컴포넌트를 하나 만들고  자식 컴포넌트로 각각 입력 모듈, 목록 출력 모듈 
  메인 컴포넌트에서 입력 및 출력을 할 수 있도록 구현

  조건)
  img태그를 사용하여 출력이 될 때 이미지도 함께 출력이 되어야함.
  option -> 능력이 된다면 JS Date를 이용하여 날짜도 함께 출력하기
*/
const Homework = () => {
    /*
    useEffect(() => {
        console.log(img)
    },[img])
    */
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
        <Main />
    )
};

export default Homework;
