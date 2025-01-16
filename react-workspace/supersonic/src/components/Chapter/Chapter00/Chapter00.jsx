import Introduce from "../../modules/Introduce";
import Example from "../../modules/SecondModule";
import WhatIsComponent from "../../modules/WhatIsComponent";
import WhatIsJSX from "../../modules/WhatIsJSX";
import WhatIsReact from "../../modules/WhatisReact";

const Chap00 = () => {
  return (
    <div>
      <WhatIsReact />
      <WhatIsJSX />
      <WhatIsComponent />
      <Introduce />
      <Example />
    </div>
  );
};

export default Chap00;
