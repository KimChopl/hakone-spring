import axios from "axios";
import { useEffect } from "react";

const Ship = () => {
  useEffect(() => {
    let url =
      "http://211.237.50.150:7080/openapi/sample/json/Grid_20220822000000000623_1/1/5?DATES=20120827";

    axios
      .get(url, {
        headers: {
          "Content-Type": "application/json",
        },
      })
      .then((r) => console.log(r))
      .catch((er) => console.log(er));
  });
};

export default Ship;
