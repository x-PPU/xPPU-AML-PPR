import xml.etree.cElementTree as ET
import pandas as pd

### uncomment desired file ###
tree = ET.parse('../QueryOutput/Process_to_Resource_to_Product_Queryresult.xml')
#tree = ET.parse('../QueryOutput/Product_to_Process_to_Resource_Queryresult.xml')
#tree = ET.parse('../QueryOutput/Resource_to_Process_to_Product_Queryresult.xml')
#tree = ET.parse('../QueryOutput/Top_Level_Process_to_Resource_to_Product_Queryresult.xml')
#tree = ET.parse('../QueryOutput/Top_Level_Product_to_Process_to_Resource_Queryresult.xml')
#tree = ET.parse('../QueryOutput/Top_Level_Resource_to_Process_to_Product_Queryresult.xml')

root = tree.getroot()
rows = []

if root.findall('Process'):
    process_elements = root.findall('Process')
    df_cols = ['ProcessConnection', 'ProcessID', 'ResourceConnection', 'ResourceID', 'ProductName', 'ProductID']
    for process_element in process_elements:
        triple = []
        process_name = process_element.find('Name').text
        process_id = process_element.find('ID').text
        if process_element.findall('Resource'):
            resource_elements = process_element.findall('Resource')
            for resource_element in resource_elements:
                resource_name = resource_element.find('Name').text
                resource_id = resource_element.find('ID').text
                product_elements = resource_element.findall('Product')
                for product_element in product_elements:
                    product_id = product_element.find('ID').text
                    product_name = product_element.find('Name').text
                    triple = [process_name, process_id, resource_name, resource_id, product_name, product_id]
                    rows.append(triple)
        if process_element.findall('Product'):
            product_elements = process_element.findall('Product')
            for product_element in product_elements:
                product_id = product_element.find('ID').text
                product_name = product_element.find('Name').text
                resource_elements = product_element.findall('Resource')
                for resource_element in resource_elements:
                    resource_name = resource_element.find('Name').text
                    resource_id = resource_element.find('ID').text
                    triple = [process_name, process_id, product_name, product_id, resource_name, resource_id]
                    rows.append(triple)

if root.findall('Product'):
    product_elements = root.findall('Product')
    df_cols = ['ProductName', 'ProductID', 'ProcessConnection', 'ProcessID', 'ResourceConnection', 'ResourceID']
    for product_element in product_elements:
        product_id = product_element.find('ID').text
        product_name = product_element.find('Name').text
        process_elements = product_element.findall('Process')
        for process_element in process_elements:
            process_name = process_element.find('Name').text
            process_id = process_element.find('ID').text
            resource_elements = process_element.findall('Resource')
            for resource_element in resource_elements:
                resource_name = resource_element.find('Name').text
                resource_id = resource_element.find('ID').text
                triple = [product_name, product_id, process_name, process_id, resource_name, resource_id]
                rows.append(triple)

if root.findall('Resource'):
    resource_elements = root.findall('Resource')
    df_cols = ['ResourceConnection', 'ResourceID', 'ProcessConnection', 'ProcessID', 'ProductName', 'ProductID']
    for resource_element in resource_elements:
        resource_name = resource_element.find('Name').text
        resource_id = resource_element.find('ID').text
        process_elements = resource_element.findall('Process')
        for process_element in process_elements:
            process_name = process_element.find('Name').text
            process_id = process_element.find('ID').text
            product_elements = process_element.findall('Product')
            for product_element in product_elements:
                product_id = product_element.find('ID').text
                product_name = product_element.find('Name').text
                triple = [resource_name, resource_id, process_name, process_id, product_name, product_id]
                rows.append(triple)


df = pd.DataFrame(rows, columns=df_cols)
df.to_csv(r'output.csv', index=False)