import "./App.css";
import Header from "./components/header/Header";
import Footer from "./components/footer/Footer";
import Signup from "./components/auth/signup/Signup";
import { Route, Routes } from "react-router-dom";
import Login from "./components/auth/signin/Login";
import { AuthProvider } from "./components/context/AuthContext";
import MyPage from "./components/auth/mypage/MyPage";
import BoardList from "./components/board/BoardList";
import InsertForm from "./components/board/InsertForm";
import BoardDetail from "./components/board/BoardDetail";
import EditBoard from "./components/board/EditBoard";

function App() {
  return (
    <div className="App">
      <AuthProvider>
        <Header />
        <Routes>
          <Route path="/signup" element={<Signup />} />
          <Route path="/signin" element={<Login />} />
          <Route path="/mypage" element={<MyPage />} />
          <Route path="/boards" element={<BoardList />} />
          <Route path="/boards/insert" element={<InsertForm />} />
          <Route path="/boards/:id" element={<BoardDetail />} />
          <Route path="/boards/:id/edit" element={<EditBoard />} />
        </Routes>
        <Footer />
      </AuthProvider>
    </div>
  );
}

export default App;
