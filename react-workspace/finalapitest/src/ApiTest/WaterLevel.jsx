import axios from "axios";
import { useEffect } from "react";

const WaterLevel = () => {
  useEffect(() => {
    let url = "http://www.wamis.go.kr:8080/wamis/openapi/wkw/wl_dubwlobs";
    url += "?basin=1";
    url += "&output=json";

    axios.get(url).then((r) => console.log(r));
  });
};

export default WaterLevel;
