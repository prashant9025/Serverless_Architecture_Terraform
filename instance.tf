resource aws_instance "i1"{
 
 count = 3
 ami = "ami-047126e50991d067b"
 availability_zone =  "ap-southeast-1a"
 instance_type = "t2.micro"
 
 tags = {
    Name = "TF_instance_${count.index + 0}"

}
}