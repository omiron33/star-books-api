class LibrariesController < ApplicationController

    def index
        @libraries = Library.all
        render json: @libraries, include: '**'
    end

    def show
        @library = Library.find(params[:id])
        render json: @library, include: '**'
    end

    def upload
        require 'json'
        file = File.read(Rails.root + 'storage/data.json')
        data_hash = JSON.parse(file)
        if Library.exists?(:id => data_hash['satellite_id'])
            library = Library.find(data_hash['satellite_id'])
            library.update(timestamp: data_hash['timestamp'])
            library.save
            unless data_hash['collection'].empty?
                data_hash['collection'].each do |set|
                    if Collection.where(set_id: set['set_id']).exists?
                        collection = Collection.where(set_id: set['set_id']).take
                        collection.update(condition: set['condition'], status: set['status'])
                        unless set['errors'].empty?
                            @problems = collection.problems
                            @problems.destroy_all
                            set['errors'].each do |error|
                                problem = Problem.new(description: error, collection_id: collection.id)
                                if problem.valid?
                                    problem.save
                                else 
                                    problem.errors.full_messages.each do |error|
                                        p error
                                    end
                                end
                            end
                        else 
                            @problems = collection.problems
                            @problems.destroy_all
                        end
                        collection.save
                    else
                        collection = Collection.new(set_id: set['set_id'], condition: set['condition'], status: set['status'], library_id: library.id)
                        if collection.valid?
                            collection.save
                            unless set['errors'].empty?
                                set['errors'].each do |error|
                                    problem = Problem.new(description: error, collection_id: collection.id)
                                    if problem.valid?
                                        problem.save
                                    else 
                                        problem.errors.full_messages.each do |error|
                                            p error
                                        end
                                    end
                                end
                            end
                        else
                            collection.errors.full_messages.each do |message|
                                p message
                            end
                        end
                    end
                end
            end
        else 
            library = Library.new(id: data_hash['satellite_id'], timestamp: data_hash['timestamp'])
            if library.valid?
                library.save
                unless data_hash['collection'].empty?
                    data_hash['collection'].each do |set|
                        collection = Collection.new(set_id: set['set_id'], condition: set['condition'], status: set['status'], library_id: library.id)
                        if collection.valid?
                            collection.save
                            unless set['errors'].empty?
                                set['errors'].each do |error|
                                    problem = Problem.new(description: error, collection_id: collection.id)
                                    if problem.valid?
                                        problem.save
                                    else 
                                        problem.errors.full_messages.each do |error|
                                            p error
                                        end
                                    end
                                end
                            end
                        else
                            collection.errors.full_messages.each do |message|
                                p message
                            end
                        end
                    end
                end
            else 
                redirect_to libraries_path
            end

        end
        redirect_to libraries_path
    end

    

end
