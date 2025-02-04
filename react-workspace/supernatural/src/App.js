import "./App.css";
import Header from "./components/header/Header";
import Footer from "./components/footer/Footer";
import Signup from "./components/auth/signup/Signup";
import { Route, Routes } from "react-router-dom";
import Login from "./components/auth/signin/Login";
import { AuthProvider } from "./components/context/AuthContext";
import MyPage from "./components/auth/mypage/MyPage";

function App() {
  return (
    <div className="App">
      <AuthProvider>
        <Header />
        <Routes>
          <Route path="/signup" element={<Signup />} />
          <Route path="/signin" element={<Login />} />
          <Route path="/mypage" element={<MyPage />} />
        </Routes>
        <Footer />
      </AuthProvider>
    </div>
  );
}

export default App;
