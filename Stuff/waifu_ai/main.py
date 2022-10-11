from operator import truediv
import os
import torch
from torch import autocast
from PIL import Image;
from diffusers import StableDiffusionPipeline, DDIMScheduler

print("Starting...")
model_id = "hakurei/waifu-diffusion"
device = "cuda"

print("Loading Model")
pipe = StableDiffusionPipeline.from_pretrained(
    model_id,
    torch_dtype=torch.float16,
    revision="fp16",
    scheduler=DDIMScheduler(
        beta_start=0.00085,
        beta_end=0.012,
        beta_schedule="scaled_linear",
        clip_sample=False,
        set_alpha_to_one=False,
    ),
)
pipe = pipe.to(device)
print("finished loading Model")
base_dir_name = os.path.dirname(__file__)

while True:
    prompt = input("Enter prompt:")
    amount = input("Enter amount of images to generate:")
    samples = input("Enter Number of inference steps to use while generating images:")
    for i in range(0, int(amount)):
        with autocast("cuda"):
            image = pipe(prompt, guidance_scale=7.5, num_inference_steps=int(samples))["sample"][0]  
        if int(amount) > 1:
            image.save(prompt + str(i) + ".png")
        else:
            image.save(prompt + ".png")    
            with Image.open(prompt + ".png") as im:
                im.show()
    print("finished")