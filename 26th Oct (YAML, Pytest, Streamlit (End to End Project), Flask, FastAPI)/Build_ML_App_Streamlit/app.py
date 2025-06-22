import streamlit as st
# streamlit run app.py - terminal
st.title("Streamlit Demo for Frontened Production")
st.header("Heading of Streamlit")
st.subheader("Sub-Heading of Streamlit")
st.text("This is just an example test")
st.success("Success")
st.warning("Warning")
st.info("information")
st.error("Error")

if st.checkbox("Select/UnSelect"):
     st.text("User selected the checkbox")
else:
     st.text("User has not selected the checkbox")



state = st.radio("What is your favorite color ?",
("Red","Green","Yellow"))
if state =="Green":
   st.success("That's my favorite color as well")
occupation = st.selectbox("What do you do?",
                         ["Student","Vlogger","Engineer","DataScientist"])
st.text(f"Select option is {occupation}")
if st.button("Example Button"):
   st.error("You cliked it")
st.sidebar.header("Heading of sidebar")
st.sidebar.text("Created by Anand Sagar for dummy purpose")





