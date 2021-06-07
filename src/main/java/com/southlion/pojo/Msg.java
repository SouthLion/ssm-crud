package com.southlion.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * @author ZhangZhengtao
 * @Description
 * @create 2021-06-06 10:27
 */
public class Msg {
    //状态码 100-成功 200-失败
    private int code;
    //提示信息
    private String msg;
    //用户要返回给浏览器的数据
    private Map<String,Object> extenden = new HashMap<>();

    public static Msg success(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理成功！");
        return result;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理失败！");
        return result;
    }

    public Msg add(String key,Object value){
        this.getExtenden().put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtenden() {
        return extenden;
    }

    public void setExtenden(Map<String, Object> extenden) {
        this.extenden = extenden;
    }
}
