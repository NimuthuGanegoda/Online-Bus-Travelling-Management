from PIL import Image, ImageDraw, ImageFont
import os

def create_detailed_architecture(output_path):
    img = Image.new('RGB', (2400, 1800), color=(20, 11, 9))
    draw = ImageDraw.Draw(img)
    
    try:
        font_title = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 70)
        font_header = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 45)
        font_text = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 30)
    except:
        font_title = font_header = font_text = ImageFont.load_default()

    draw.text((1200, 100), "SL BusTrack - Detailed System Architecture", fill=(231, 111, 81), font=font_title, anchor="mm")

    # 1. Client Tier
    draw.rectangle([50, 200, 750, 1700], outline=(231, 111, 81), width=5)
    draw.text((400, 240), "Client Tier (Flutter)", fill=(231, 111, 81), font=font_header, anchor="mm")
    
    clients = [
        ("Passenger App", ["Real-time Map", "ETA Dashboard", "Rating System"]),
        ("Driver App", ["Trip Controller", "Crowd Monitor", "NFC Auth Module"]),
        ("Admin Dashboard", ["Global Fleet View", "Incident Triage List"])
    ]
    for i, (name, subs) in enumerate(clients):
        y = 300 + i * 450
        draw.rectangle([100, y, 700, y+400], fill=(36, 23, 20), outline=(231, 111, 81), width=3)
        draw.text((400, y+40), name, fill=(255, 255, 255), font=font_text, anchor="mm", font_weight="bold")
        for j, sub in enumerate(subs):
            draw.text((400, y+120+j*60), "• " + sub, fill=(200, 200, 200), font=font_text, anchor="mm")

    # 2. Infrastructure Tier
    draw.rectangle([850, 200, 1550, 1700], outline=(0, 109, 119), width=5)
    draw.text((1200, 240), "Infrastructure (Supabase)", fill=(0, 109, 119), font=font_header, anchor="mm")
    
    infras = [
        ("GoTrue Auth", ["JWT Verification", "User Identity"]),
        ("PostgreSQL DB", ["Users / Drivers", "Buses / Routes", "Trip History"]),
        ("Realtime Engine", ["Location Broadcasting", "Incident Alerts"]),
        ("Edge Functions", ["ETA API", "Triage Logic"])
    ]
    for i, (name, subs) in enumerate(infras):
        y = 300 + i * 340
        draw.rectangle([900, y, 1500, y+300], fill=(8, 19, 26), outline=(0, 109, 119), width=3)
        draw.text((1200, y+40), name, fill=(255, 255, 255), font=font_text, anchor="mm")
        for j, sub in enumerate(subs):
            draw.text((1200, y+120+j*50), sub, fill=(150, 150, 150), font=font_text, anchor="mm")

    # 3. Intelligence Tier
    draw.rectangle([1650, 200, 2350, 1700], outline=(131, 56, 236), width=5)
    draw.text((2000, 240), "Intelligence (Neo AI/ML)", fill=(131, 56, 236), font=font_header, anchor="mm")
    
    intels = [
        ("ETA Prediction", ["Random Forest", "bus_arrival_model.joblib"]),
        ("Driver Analytics", ["Sentiment Analysis", "driver_rating_model.pkl"]),
        ("Incident Triage", ["Priority Ranking", "emergency_triage_model.joblib"])
    ]
    for i, (name, subs) in enumerate(intels):
        y = 300 + i * 450
        draw.rectangle([1700, y, 2300, y+400], fill=(26, 26, 26), outline=(131, 56, 236), width=3)
        draw.text((2000, y+40), name, fill=(255, 255, 255), font=font_text, anchor="mm")
        for j, sub in enumerate(subs):
            draw.text((2000, y+150+j*80), sub, fill=(180, 180, 180), font=font_text, anchor="mm")

    img.save(output_path, quality=95)

def create_detailed_usecase(output_path):
    img = Image.new('RGB', (2400, 1800), color=(8, 19, 26))
    draw = ImageDraw.Draw(img)
    
    try:
        font_title = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 70)
        font_text = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 35)
    except:
        font_title = font_text = ImageFont.load_default()

    draw.text((1200, 100), "SL BusTrack - Granular Use Case Map", fill=(0, 109, 119), font=font_title, anchor="mm")

    # System Boundary
    draw.rectangle([600, 200, 1800, 1700], outline=(0, 109, 119), width=8)
    draw.text((1200, 240), "Smart City Ecosystem", fill=(0, 109, 119), font=font_text, anchor="mm")

    # Use Cases
    ucs = [
        "Multi-Factor Authentication", 
        "Real-time GPS Tracking", 
        "ML-Powered ETA View", 
        "NFC Driver Validation", 
        "Crowd Level Reporting", 
        "Emergency Incident Log", 
        "AI Automated Triage",
        "Driver Performance Audit",
        "Fleet Resource Planning"
    ]
    for i, uc in enumerate(ucs):
        y = 350 + i * 145
        draw.ellipse([800, y-55, 1600, y+55], fill=(19, 35, 45), outline=(0, 109, 119), width=2)
        draw.text((1200, y), uc, fill=(255, 255, 255), font=font_text, anchor="mm")

    # Actors
    actors = [("Passenger", 250, 500), ("Driver", 250, 1300), ("Administrator", 2150, 600), ("Intelligence Layer", 2150, 1400)]
    for name, x, y in actors:
        # stick figure
        draw.ellipse([x-50, y-120, x+50, y-20], outline=(255, 255, 255), width=4)
        draw.line([x, y-20, x, y+120], fill=(255, 255, 255), width=4)
        draw.line([x-80, y+30, x+80, y+30], fill=(255, 255, 255), width=4)
        draw.line([x, y+120, x-60, y+220], fill=(255, 255, 255), width=4)
        draw.line([x, y+120, x+60, y+220], fill=(255, 255, 255), width=4)
        draw.text((x, y+280), name, fill=(255, 255, 255), font=font_text, anchor="mm")

    img.save(output_path, quality=95)

if __name__ == "__main__":
    create_detailed_architecture("/home/nimuthu/system_architecture.jpg")
    create_detailed_usecase("/home/nimuthu/use_case_diagram.jpg")
